import 'package:flutter/material.dart';
import 'package:mini_project_one/views/widgets/image_section.dart';
import 'package:mini_project_one/views/widgets/post_card.dart';
import 'package:mini_project_one/views/widgets/the_end.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.feed_rounded),
        title: const Text("Feeds"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 10),
        children: [
          ///My Day Section
          const ImageSection(),

          ///Post Section
          for (int i = 0; i < 10; i++)
            PostCard(
              onTap: () {
                Navigator.of(context).pushNamed("/details");
              },
            ),

          const TheEnd()
        ],
      ),
    );
  }
}
