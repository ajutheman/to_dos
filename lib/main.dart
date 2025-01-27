import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User To-Dos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = fetchUsers();
    checkConnectivity();
  }

  Future<List<dynamic>> fetchUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedUsers = prefs.getString('users');
    if (cachedUsers != null) {
      return jsonDecode(cachedUsers);
    }
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final users = jsonDecode(response.body);
        prefs.setString('users', jsonEncode(users));
        return users;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching users: $e');
      return [];
    }
  }

  Future<void> checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(msg: 'No internet connection');
    } else {
      Fluttertoast.showToast(msg: 'Internet connection available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['name']),
                subtitle: Text(user['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(user: user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class UserDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late Future<List<dynamic>> todosFuture;
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    todosFuture = fetchTodos(widget.user['id']);
    getCurrentLocation();
  }

  Future<List<dynamic>> fetchTodos(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedTodos = prefs.getString('todos_$userId');
    if (cachedTodos != null) {
      return jsonDecode(cachedTodos);
    }
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=$userId'));
      if (response.statusCode == 200) {
        final todos = jsonDecode(response.body);
        prefs.setString('todos_$userId', jsonEncode(todos));
        return todos;
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching todos: $e');
      return [];
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      final hasPermission = await LocationService.requestPermission();
      if (!hasPermission) {
        Fluttertoast.showToast(msg: 'Location permission denied');
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = position;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['name']),
      ),
      body: Column(
        children: [
          if (currentPosition != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Current Position: ${currentPosition!.latitude}, ${currentPosition!.longitude}',
              ),
            ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: todosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No to-dos found'));
                }
                final todos = snapshot.data!;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      title: Text(todo['title']),
                      trailing: Icon(
                        todo['completed'] ? Icons.check_circle : Icons.circle_outlined,
                        color: todo['completed'] ? Colors.green : Colors.grey,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LocationService {
  static Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission != LocationPermission.deniedForever && permission != LocationPermission.denied;
  }
}
