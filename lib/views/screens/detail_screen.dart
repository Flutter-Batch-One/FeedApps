import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_one/views/widgets/circle_profile.dart';
import 'package:mini_project_one/views/widgets/image_section.dart';
import 'package:mini_project_one/views/widgets/post_card.dart';
import 'package:mini_project_one/views/widgets/the_end.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ye Myo Aung"),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 10),
        children: [
          Container(
            color: Colors.white,
            height: 230,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "https://via.placeholder.com/600/92c952",
                  height: 200,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  left: 10,
                  bottom: 0,
                  child: CircleProfile(
                    radius: 60,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  child: Text(
                    "Ye Myo Aung",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    StaticCard(
                      width: 110,
                      icon: Icons.article,
                      label: "100 Posts",
                    ),
                    StaticCard(
                      width: 120,
                      icon: Icons.photo_rounded,
                      label: "100 Albums",
                    ),
                  ],
                ),
              ],
            ),
          ),
          const ImageSection(
            showProfileImage: false,
          ),
          for (int i = 0; i < 10; i++)
            const PostCard(
              onTap: null,
            ),
          const TheEnd()
        ],
      ),
    );
  }
}

class StaticCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final String label;
  const StaticCard({
    super.key,
    required this.width,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(175, 177, 169, 0.2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
