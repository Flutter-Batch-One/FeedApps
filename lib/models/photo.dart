import 'package:mini_project_one/models/user.dart';

class PhotoModel {
  final int albumId, id;
  final String title, url, thumbnailUrl;

  late UserModel user;

  PhotoModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory PhotoModel.fromJsObject(dynamic jsObject) {
    return PhotoModel(
      id: int.parse(jsObject['id'].toString()),
      albumId: int.parse(jsObject['albumId'].toString()),
      title: jsObject['title'],
      url: jsObject['url'],
      thumbnailUrl: jsObject['thumbnailUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "albumId": albumId,
      "title": title,
      "url": url,
      "thumbnailUrl": thumbnailUrl,
    };
  }
}
