import "package:mini_project_one/models/user.dart";
import "package:mini_project_one/repositories/api_repository.dart";

class UserController {
  final ApiRepository api;
  UserController(this.api);

  Future<List<UserModel>> getUsers() async {
    ///js object
    final List users =
        await api.get("https://jsonplaceholder.typicode.com/users");

    return users.map(UserModel.fromJsObject).toList();
  }
}
