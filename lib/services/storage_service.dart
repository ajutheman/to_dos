import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/todo_model.dart';

class StorageService {
  Future<void> saveUsers(List<User> users) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('users', json.encode(users.map((u) => u.toJson()).toList()));
  }

  Future<List<User>> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersString = prefs.getString('users');
    if (usersString != null) {
      List<dynamic> usersJson = json.decode(usersString);
      return usersJson.map((json) => User.fromJson(json)).toList();
    }
    return [];
  }

  Future<void> saveToDos(List<ToDo> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('todos', json.encode(todos.map((t) => t.toJson()).toList()));
  }

  Future<List<ToDo>> getToDos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todosString = prefs.getString('todos');
    if (todosString != null) {
      List<dynamic> todosJson = json.decode(todosString);
      return todosJson.map((json) => ToDo.fromJson(json)).toList();
    }
    return [];
  }
}