import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_one/controllers/album_controller.dart';
import 'package:mini_project_one/controllers/feed_controller.dart';
import 'package:mini_project_one/controllers/post_controller.dart';
import 'package:mini_project_one/controllers/user_controller.dart';
import 'package:mini_project_one/models/album.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/models/post.dart';
import 'package:mini_project_one/models/user.dart';
import 'package:mini_project_one/repositories/api_repository.dart';
import 'package:mini_project_one/views/widgets/image_section.dart';
import 'package:mini_project_one/views/widgets/post_card.dart';
import 'package:mini_project_one/views/widgets/the_end.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiRepository repository = ApiRepository(Dio());
  late final FeedController controller;

  bool isLoading = true;

  final List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    controller = FeedController(
      userController: UserController(repository),
      postController: PostController(repository),
      albumController: AlbumController(repository),
    );
    controller.getUsers().then((value) {
      isLoading = false;
      users.addAll(value);
      setState(() {});
    });
  }

  /// users.map((e) => e.posts)
  /// [1,2,3,4,5].fold(
  //   1,
  //   (11, 5) => ) ///16 combine
  // .shuffle() // return
  // []..shuffle()///return

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.only(bottom: 10),
              children: [
                ///My Day Section
                ImageSection(
                  photos: users.map((e) => e.albums).fold(
                    <PhotoModel>[],
                    (previousValue, element) => [
                      ...previousValue,
                      element[1].photos.fold(
                          <PhotoModel>[],
                          (previousValue, element) =>
                              [...previousValue, element])[0]
                    ],
                  )..shuffle(),
                ),

                ///Post Section
                for (var i in users.map((e) => e.posts).fold(
                  <PostModel>[],
                  (previousValue, element) => [...previousValue, ...element],
                )..shuffle())
                  PostCard(
                    post: i,
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
