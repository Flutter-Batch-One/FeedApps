import 'package:mini_project_one/models/comment.dart';
import 'package:mini_project_one/models/user.dart';

class PostModel {
  final int userId, id;
  final String title, body;

  final List<CommentModel> comments;

  late UserModel user;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  }) : comments = [];

  factory PostModel.fromJsObject(dynamic jsObject) {
    return PostModel(
      id: int.parse(jsObject['id'].toString()),
      userId: int.parse(jsObject['userId'].toString()),
      title: jsObject['title'],
      body: jsObject['body'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
      "body": body,
    };
  }
}
