import 'package:todolist/model/user.dart';

class UserManager {
  static List<User> users = [];
  static User? loggedUser;

  static User findUser(String login, String haslo) {
    for (User user in users) {
      if (user.login == login && user.password == haslo) {
        loggedUser = user;
        return user;
      }
    }
    return User(id: "", login: "", password: "", name: "");
  }
}
