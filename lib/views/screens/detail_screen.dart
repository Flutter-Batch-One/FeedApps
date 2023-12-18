import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/models/user.dart';
import 'package:mini_project_one/views/screens/not_found_screen.dart';
import 'package:mini_project_one/views/widgets/circle_profile.dart';
import 'package:mini_project_one/views/widgets/image_section.dart';
import 'package:mini_project_one/views/widgets/post_card.dart';
import 'package:mini_project_one/views/widgets/the_end.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = ModalRoute.of(context)?.settings.arguments;

    if (user == null || user is! UserModel) {
      return NotFoundScreen();
    }

    final coverPhotos = user.albums[1].photos;

    final featurePhotos = user.albums.sublist(2).fold(<PhotoModel>[],
        (previousValue, element) => [...previousValue, ...element.photos]);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(user.name),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 10),
        children: [
          Container(
            color: Colors.white,
            height: 230,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/view',
                      arguments: coverPhotos,
                    );
                  },
                  child: CachedNetworkImage(
                    imageUrl: coverPhotos.first.url,
                    height: 200,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 0,
                  child: CircleProfile(
                    name: user.name[0],
                    radius: 60,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 90,
            color: Colors.white,
            child: Column(
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
                    user.name,
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
                      label: "${user.posts.length} Posts",
                    ),
                    StaticCard(
                      width: 120,
                      icon: Icons.photo_rounded,
                      label: "${user.albums.length} Albums",
                    ),
                  ],
                ),
              ],
            ),
          ),
          ImageSection(
            showProfileImage: false,
            photos: featurePhotos,
          ),
          for (int i = 0; i < user.posts.length; i++)
            PostCard(
              post: user.posts[i],
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
