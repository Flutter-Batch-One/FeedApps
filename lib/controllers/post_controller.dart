import 'package:mini_project_one/models/comment.dart';
import 'package:mini_project_one/models/post.dart';
import 'package:mini_project_one/repositories/api_repository.dart';

class PostController {
  final ApiRepository api;

  PostController(this.api);

  List<PostModel> match(
    List<PostModel> posts,
    List<List<CommentModel>> comments,
  ) {
    for (var i = 0; i < posts.length; i++) {
      posts[i].comments.addAll(comments[i]);
    }
    return posts;
  }

  Future<List<PostModel>> getPosts(int userId) async {
    final List response = await api.get(
        "https://jsonplaceholder.typicode.com/posts?userId=$userId",
        'cached_posts');

    final List<PostModel> posts = response.map(PostModel.fromJsObject).toList();
    final List<List<CommentModel>> comments =
        await Future.wait(posts.map((e) => getComments(e.id)).toList());

    return match(posts, comments);
  }

  Future<List<CommentModel>> getComments(int postId) async {
    final List response = await api.get(
        "https://jsonplaceholder.typicode.com/comments?postId=$postId",
        'cached_comments');

    return response.map(CommentModel.fromJsObject).toList();
  }
}
