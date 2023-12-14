import 'package:mini_project_one/controllers/album_controller.dart';
import 'package:mini_project_one/controllers/post_controller.dart';
import 'package:mini_project_one/controllers/user_controller.dart';
import 'package:mini_project_one/models/album.dart';
import 'package:mini_project_one/models/post.dart';
import 'package:mini_project_one/models/user.dart';

class FeedController {
  final UserController userController;
  final PostController postController;
  final AlbumController albumController;

  FeedController({
    required this.userController,
    required this.postController,
    required this.albumController,
  });

  ///1 Get All Users
  ///2 Related Post,Album
  ///3 Show

  Future<List<UserModel>> getUsers() async {
    final List<UserModel> users = await userController.getUsers();

    ///Post
    final List<Future<List<PostModel>>> posts = users.map((e) {
      return getPosts(e.id);
    }).toList();

    ///List<Future<List<PostModel>>>

    final List<Future<List<AlbumModel>>> albums = users.map(getAlbums).toList();

    ///List<List<PostModel>>
    final List<List<PostModel>> userPosts = await Future.wait(posts);

    final List<List<AlbumModel>> userAlbums = await Future.wait(albums);

    for (var i = 0; i < users.length; i++) {
      final user = users[i];
      final posts = userPosts[i];

      user.posts.addAll(posts.map((e) {
        e.user = user;
        return e;
      }));
      user.albums.addAll(userAlbums[i]);
    }

    return users;
  }

  Future<List<PostModel>> getPosts(int userId) async {
    return postController.getPosts(userId);
  }

  Future<List<AlbumModel>> getAlbums(UserModel user) async {
    return albumController.getAlbums(user);
  }
}
