import 'package:mini_project_one/models/album.dart';
import 'package:mini_project_one/models/comment.dart';
import 'package:mini_project_one/models/post.dart';

class UserModel {
  final int id;
  final String name, username, email;

  final List<PostModel> posts;
  final List<CommentModel> comments;
  final List<AlbumModel> albums;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  })  : posts = [],
        comments = [],
        albums = [];

  factory UserModel.fromJsObject(dynamic jsObject) {
    return UserModel(
      id: int.parse(jsObject['id'].toString()),
      name: jsObject['name'],
      username: jsObject['username'],
      email: jsObject['email'],
    );
  }
}
