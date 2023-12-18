import 'package:mini_project_one/controllers/album_controller.dart';
import 'package:mini_project_one/controllers/post_controller.dart';
import 'package:mini_project_one/controllers/user_controller.dart';
import 'package:mini_project_one/models/album.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/models/post.dart';
import 'package:mini_project_one/models/user.dart';
import 'package:mini_project_one/repositories/cache_repository.dart';

import '../models/comment.dart';

class LoadResponse {
  final bool isNewData;
  final List<UserModel> users;
  final List<List<PostModel>> posts;
  final List<List<AlbumModel>> albums;

  LoadResponse(this.users, this.posts, this.albums, this.isNewData);
}

class GetPost {
  final int id;

  GetPost(this.id);
}

class FeedController {
  final CacheRepository repository;
  final UserController userController;
  final PostController postController;
  final AlbumController albumController;

  FeedController({
    required this.repository,
    required this.userController,
    required this.postController,
    required this.albumController,
  });

  ///1 Get All Users
  ///2 Related Post,Album
  ///3 Show
  ///1 one

  static List<UserModel> users = [];

  // static a() {
  //   users;
  // }

  Future<List> loadFromCacheWithFold(
    List parents,
    String collection,
    dynamic Function(dynamic) parser,
  ) async {
    final result = await loadFromCache(parents, collection, parser);

    ///index 0
    return result.fold<List>(
        [], (List previousValue, element) => [...previousValue, ...element]);
  }

  Future<List> get(String collection, Function(dynamic) parser) async {
    final result = await repository.get(collection);
    return result.map(parser).toList();
  }

  Future<List<List>> loadFromCache(
    List parents,
    String collection,
    dynamic Function(dynamic) parser,
  ) async {
    final futures =
        parents.map((child) => get("$collection${child.id}", parser));
    final List<List<dynamic>> result = await Future.wait(futures);
    return result;
  }

  Future<List<UserModel>> getUsers() async {
    final model = await load();
    match(model.users, model.posts, model.albums);
    if (model.isNewData) repository.save(users);
    return users;
  }

  Future<List<PostModel>> getPostWithComments(int userId) async {
    final userRelatedPosts = (await loadFromCacheWithFold(
            [GetPost(userId)], "cache_posts_", PostModel.fromJsObject))
        .map((e) => e as PostModel)
        .toList();

    final List<List<CommentModel>> postRelatedComments = (await loadFromCache(
            userRelatedPosts, "cache_comments_", CommentModel.fromJsObject))
        .map((e) => e.map((e) => e as CommentModel).toList())
        .toList();

    return this.postController.match(userRelatedPosts, postRelatedComments);
  }

  Future<List<AlbumModel>> getAlbumWithPhotos(UserModel user) async {
    final List<AlbumModel> cacheAlbums = (await loadFromCacheWithFold(
            [user], "cache_albums_", AlbumModel.fromJsObject))
        .map((e) => e as AlbumModel)
        .toList();
    final List<List<PhotoModel>> cachePhotos = (await loadFromCache(
            cacheAlbums, "cache_photo_", PhotoModel.fromJsObject))
        .map((e) => e.map((e) => e as PhotoModel).toList())
        .toList();

    return this.albumController.match(cacheAlbums, cachePhotos, [user]);
  }

  Future<LoadResponse> load() async {
    final List<UserModel> users = await userController.getUsers();

    // final List<PostModel> d = (await Future.wait(cacheUsers.map((e) {
    //   return repository.get("cache_albums_${e.id}").then((value) {
    //     return value.map(PostModel.fromJsObject).toList();
    //   });
    // })))
    //     .fold(<PostModel>[],
    //         (previousValue, element) => [...previousValue, ...element]);

    if (users.isEmpty) {
      // print("Not Internet");
      final List<UserModel> users = (await repository.get("cache_users"))
          .map(UserModel.fromJsObject)
          .toList();

      ///NO INTERNET
      // final List<PostModel> cachePosts = (await loadFromCacheWithFold(
      //         users, "cache_posts_", PostModel.fromJsObject))
      //     .map((e) => e as PostModel)
      //     .toList();
      //
      // final List<List<CommentModel>> cacheComments = (await loadFromCache(
      //         cachePosts, "cache_comments_", CommentModel.fromJsObject))
      //     .map((e) => e.map((e) => e as CommentModel).toList())
      //     .toList();
      //
      // final List<PostModel> matchPostModels =
      //     postController.match(cachePosts, cacheComments);

      ////
      // final List<AlbumModel> cacheAlbums = (await loadFromCacheWithFold(
      //         users, "cache_albums_", AlbumModel.fromJsObject))
      //     .map((e) => e as AlbumModel)
      //     .toList();
      //
      // final List<List<PhotoModel>> cachePhotos = (await loadFromCache(
      //         cacheAlbums, "cache_photo_", PhotoModel.fromJsObject))
      //     .map((e) => e.map((e) => e as PhotoModel).toList())
      //     .toList();
      //
      // final List<AlbumModel> matchedAlbums =
      //     albumController.match(cacheAlbums, cachePhotos, users);

      final List<List<PostModel>> userPosts =
          await Future.wait(users.map((e) => getPostWithComments(e.id)));
      final List<List<AlbumModel>> userAlbums =
          await Future.wait(users.map(getAlbumWithPhotos));

      // for (final user in users) {
      // final data = matchPostModels
      //     .where((element) => element.userId == user.id)
      //     .toList();

      // userPosts.add(data);

      //   userAlbums.add(matchedAlbums
      //       .where((element) => element.userId == user.id)
      //       .toList());
      // }

      return LoadResponse(users, userPosts, userAlbums, false);
    }

    ///Post
    final List<Future<List<PostModel>>> posts = users.map((e) {
      return getPosts(e.id);
    }).toList();

    ///List<Future<List<PostModel>>>

    final List<Future<List<AlbumModel>>> albums = users.map(getAlbums).toList();

    ///List<List<PostModel>>
    final List<List<PostModel>> userPosts = await Future.wait(posts);

    final List<List<AlbumModel>> userAlbums = await Future.wait(albums);

    return LoadResponse(users, userPosts, userAlbums, true);
  }

  void match(List<UserModel> users, List<List<PostModel>> userPosts,
      List<List<AlbumModel>> userAlbums) {
    for (var i = 0; i < users.length; i++) {
      final user = users[i];
      final posts = userPosts[i];

      user.posts.addAll(posts.map((e) {
        e.user = user;
        return e;
      }));
      user.albums.addAll(userAlbums[i]);
    }

    FeedController.users.clear();
    FeedController.users.addAll(users);
  }

  Future<List<PostModel>> getPosts(int userId) async {
    return postController.getPosts(userId);
  }

  Future<List<AlbumModel>> getAlbums(UserModel user) async {
    return albumController.getAlbums(user);
  }
}
