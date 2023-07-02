import 'package:todolist/model/task.dart';

class User {
  String? id;
  String? name;
  String? login;
  String? password;
  List<Task> tasks;

  User({
    this.id,
    this.name,
    this.login,
    this.password,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];
}
