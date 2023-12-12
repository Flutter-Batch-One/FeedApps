import 'package:flutter/material.dart';
import 'package:mini_project_one/views/widgets/my_day_card.dart';

class ImageSection extends StatelessWidget {
  final bool showProfileImage;
  const ImageSection({
    super.key,
    this.showProfileImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        itemCount: 10,
        itemBuilder: (_, i) {
          return MyDayCard(
            showProfileImage: showProfileImage,
          );
        },
      ),
    );
  }
}
