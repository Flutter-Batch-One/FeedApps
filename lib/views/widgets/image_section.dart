import 'package:flutter/material.dart';
import 'package:mini_project_one/controllers/feed_controller.dart';
import 'package:mini_project_one/models/album.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/views/widgets/my_day_card.dart';

class ImageSection extends StatelessWidget {
  final List<PhotoModel> photos;
  final bool showProfileImage;
  const ImageSection({
    super.key,
    this.showProfileImage = true,
    this.photos = const [],
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (photos.isEmpty) return SizedBox();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      color: Colors.white,
      height: 160,
      width: size.width,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        itemBuilder: (_, i) {
          final photo = photos[i];

          final albums = FeedController.users.fold(
              <AlbumModel>[],
              (p, c) => [
                    ...p,
                    ...c.albums,
                  ]);

          final albumIndex = albums.indexWhere((al) => al.id == photo.albumId);

          ///photo remove and insert 0

          final copied = albums[albumIndex].copy();
          copied.photos.removeWhere((a) => a.id == photo.id);
          copied.photos.insert(0, photo);

          return MyDayCard(
            album: copied,
            photo: photo,
            showProfileImage: showProfileImage,
          );
        },
      ),
    );
  }
}
