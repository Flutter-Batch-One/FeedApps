import 'package:mini_project_one/models/photo.dart';

class AlbumModel {
  final int userId, id;
  final String title;

  final List<PhotoModel> photos;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  }) : photos = [];

  factory AlbumModel.fromJsObject(dynamic jsObject) {
    return AlbumModel(
      id: int.parse(jsObject['id'].toString()),
      userId: int.parse(jsObject['userId'].toString()),
      title: jsObject['title'],
    );
  }

  AlbumModel copy() {
    final news = AlbumModel(
      id: id,
      userId: userId,
      title: title,
    );
    news.photos.addAll(photos);
    return news;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userId": userId,
      "title": title,
    };
  }
}
