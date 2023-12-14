import 'package:flutter/material.dart';
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
          return MyDayCard(
            photo: photos[i],
            showProfileImage: showProfileImage,
          );
        },
      ),
    );
  }
}
