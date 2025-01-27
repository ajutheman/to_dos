import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/todo_model.dart';
import '../services/api_service.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${user.email}'),
            Text('Phone: ${user.phone}'),
            Text('Latitude: ${user.latitude}'),
            Text('Longitude: ${user.longitude}'),
            SizedBox(height: 20),
            FutureBuilder<List<ToDo>>(
              future: ApiService().fetchToDos(user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        ToDo todo = snapshot.data![index];
                        return ListTile(
                          title: Text(todo.title),
                          leading: Icon(
                            todo.completed
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}