import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:mini_project_one/controllers/album_controller.dart';
import 'package:mini_project_one/controllers/feed_controller.dart';
import 'package:mini_project_one/controllers/post_controller.dart';
import 'package:mini_project_one/controllers/user_controller.dart';
import 'package:mini_project_one/delegate/search.dart';
import 'package:mini_project_one/models/photo.dart';
import 'package:mini_project_one/models/post.dart';
import 'package:mini_project_one/models/user.dart';
import 'package:mini_project_one/repositories/api_repository.dart';
import 'package:mini_project_one/repositories/cache_repository.dart';
import 'package:mini_project_one/views/widgets/image_section.dart';
import 'package:mini_project_one/views/widgets/post_card.dart';
import 'package:mini_project_one/views/widgets/the_end.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CacheRepository cacheRepository = CacheRepository(Localstore.instance);
  final ApiRepository repository = ApiRepository(Dio());

  late final FeedController controller;

  bool isLoading = true;

  final List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    controller = FeedController(
      repository: cacheRepository,
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
  // final List data = [
  //   [1, 2, 3, 4, 5, 6],
  //   123,
  //   [1, 2, 3]
  // ];
  //
  // void test(data) {
  //   if (data is List) {
  //     data.forEach(test);
  //     return;
  //   }
  //   print("Data is $data");
  // }

  // void test(
  //   List users,
  //   List<String> collections,
  // ) {
  //   for (int i = 0; i < collections.length; i++) {
  //     if (i == 0) {
  //       print(users);
  //       continue;
  //     }
  //     test(get(), [collections[i]]);
  //   }
  // }
  //
  // List get() {
  //   return List.generate(10, (index) => index);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.feed_rounded),
        title: const Text("Feeds"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchScreen());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     test([1, 2, 3],
      //         ['cache_posts_', 'cache_comments_', 'fadsjfka', 'fasdjkl']);
      //   },
      //   child: Text("Test"),
      // ),
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
                for (var post in users.map((e) => e.posts).fold(
                  <PostModel>[],
                  (previousValue, element) => [...previousValue, ...element],
                )..shuffle())
                  PostCard(
                    post: post,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/details",
                        arguments: users
                            .firstWhere((element) => element.id == post.userId),
                      );
                    },
                  ),

                const TheEnd()
              ],
            ),
    );
  }
}
