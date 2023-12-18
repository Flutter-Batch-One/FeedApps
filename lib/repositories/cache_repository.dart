import 'package:localstore/localstore.dart';
import 'package:mini_project_one/models/user.dart';

class CacheRepository {
  final Localstore localstore;

  CacheRepository(this.localstore);

  // Future<dynamic> save(
  //   String collection,
  //   List<Map<String, dynamic>> data,
  // ) async {
  //   final ref = localstore.collection(collection);
  //   return Future.wait(data.map((e) => ref.doc(e['id']?.toString()).set(e)));
  // }

  Future<List> get(
    String collection,
  ) async {
    final result = await localstore.collection(collection).get();
    return result?.values.toList() ?? [];
  }

  Future<void> save(List<UserModel> users) async {
    final userRef = localstore.collection("cache_users");

    // for (var user in users) {
    //   userRef.doc(user.id.toString()).set(user.toMap());
    //   for (var post in user.posts) {
    //     postRef.doc(post.id.toString()).set(post.toMap());
    //     for (var comment in post.comments) {
    //       commentRef.doc(comment.id.toString()).set(comment.toMap());
    //     }
    //   }
    //   for (var album in user.albums) {
    //     albumRef.doc(album.id.toString()).set(album.toMap());
    //     for (var photo in album.photos) {
    //       photoRef.doc(photo.id.toString()).set(photo.toMap());
    //     }
    //   }
    // }
    return Future(() {
      for (var user in users) {
        userRef.doc(user.id.toString()).set(user.toMap());
        final postRef = localstore.collection("cache_posts_${user.id}");

        for (var post in user.posts) {
          postRef.doc(post.id.toString()).set(post.toMap());
          final commentRef = localstore.collection("cache_comments_${post.id}");
          for (var comment in post.comments) {
            commentRef.doc(comment.id.toString()).set(comment.toMap());
          }
        }
        final albumRef = localstore.collection("cache_albums_${user.id}");
        for (var album in user.albums) {
          albumRef.doc(album.id.toString()).set(album.toMap());
          final photoRef = localstore.collection("cache_photo_${album.id}");
          for (var photo in album.photos) {
            photoRef.doc(photo.id.toString()).set(photo.toMap());
          }
        }
      }
    });
  }
}
