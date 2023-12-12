import 'package:flutter/material.dart';

class CircleProfile extends StatelessWidget {
  final double radius;
  const CircleProfile({
    super.key,
    this.radius = 17,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: const Text(
        "A",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
