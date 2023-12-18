import 'package:mini_project_one/models/album.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/models/user.dart';
import 'package:mini_project_one/repositories/api_repository.dart';

class AlbumController {
  final ApiRepository api;

  AlbumController(this.api);

  List<AlbumModel> match(List<AlbumModel> albums, List<List<PhotoModel>> photos,
      List<UserModel> user) {
    for (var album in albums) {
      album.photos.addAll(
        photos[albums.indexWhere((element) => element.id == album.id)].map((e) {
          e.user = user.firstWhere((element) => element.id == album.userId);
          return e;
        }),
      );
    }
    return albums;
  }

  Future<List<AlbumModel>> getAlbums(UserModel user) async {
    final List response = await api.get(
        "https://jsonplaceholder.typicode.com/albums?userId=${user.id}",
        'cached_albums');

    final List<AlbumModel> albums =
        response.map(AlbumModel.fromJsObject).toList();
    final List<List<PhotoModel>> photos =
        await Future.wait(albums.map((e) => getPhotos(e.id)).toList());

    return match(albums, photos, [user]);
  }

  Future<List<PhotoModel>> getPhotos(int photoId) async {
    final List response = await api.get(
      "https://jsonplaceholder.typicode.com/photos?albumId=$photoId",
      'cached_photos',
    );

    return response.map(PhotoModel.fromJsObject).toList();
  }
}
