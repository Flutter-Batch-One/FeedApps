import 'package:flutter/material.dart';
import 'package:mini_project_one/controllers/feed_controller.dart';

import '../models/post.dart';
import '../views/widgets/post_card.dart';

class SearchScreen extends SearchDelegate {
  final List<PostModel> _posts = [];

  List<PostModel> get posts {
    if (_posts.isEmpty) {
      // _posts.addAll(FeedController.users.fold([],
      //     (previousValue, element) => [...previousValue, ...element.posts]));

      for (final user in FeedController.users) {
        _posts.addAll(user.posts);
      }
    }
    return _posts;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [SizedBox()];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchedPosts = posts
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()) ||
            element.body.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchedPosts.length,
      itemBuilder: (_, i) {
        return PostCard(
          post: searchedPosts[i],
          onTap: () {
            Navigator.of(context).pushNamed(
              "/details",
              arguments: FeedController.users.firstWhere(
                  (element) => element.id == searchedPosts[i].userId),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchedPosts = posts
        .where((element) =>
            element.title.toLowerCase().startsWith(query.toLowerCase()) ||
            element.body.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: searchedPosts.length,
      itemBuilder: (_, i) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              "/details",
              arguments: FeedController.users.firstWhere(
                  (element) => element.id == searchedPosts[i].userId),
            );
          },
          tileColor: Colors.white,
          title: Text(searchedPosts[i].title),
        );
      },
    );
  }
}
