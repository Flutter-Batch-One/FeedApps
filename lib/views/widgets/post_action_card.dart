import 'package:flutter/material.dart';

class PostActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  const PostActionButton({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () {
        print("Tap $label");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 5,
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
