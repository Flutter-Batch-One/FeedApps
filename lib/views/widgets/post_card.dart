import 'package:flutter/material.dart';
import 'package:mini_project_one/views/widgets/circle_profile.dart';
import 'package:mini_project_one/views/widgets/post_action_card.dart';

class PostCard extends StatelessWidget {
  final void Function()? onTap;
  const PostCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap,
              child: const Row(
                children: [
                  CircleProfile(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ye Myo Aung",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Text("Title"),
            ),
            const Text("body"),
            const Divider(),
            const SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PostActionButton(
                    icon: Icons.favorite_border,
                    label: "Favorite",
                  ),
                  PostActionButton(
                    icon: Icons.mode_comment_outlined,
                    label: "Comment",
                  ),
                  PostActionButton(
                    icon: Icons.share,
                    label: "Share",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
