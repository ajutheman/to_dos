import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorageService {
  Future<void> storeUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('users', json.encode(users));
  }

  Future<List<Map<String, dynamic>>> fetchUsersFromLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersString = prefs.getString('users');
    if (usersString == null) {
      return [];
    }
    return List<Map<String, dynamic>>.from(json.decode(usersString));
  }

  Future<void> storeTodos(int userId, List<Map<String, dynamic>> todos) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('todos_user_$userId', json.encode(todos));
  }

  Future<List<Map<String, dynamic>>> fetchTodosFromLocal(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos_user_$userId');
    if (todosString == null) {
      return [];
    }
    return List<Map<String, dynamic>>.from(json.decode(todosString));
  }
}
