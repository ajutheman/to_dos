// import 'package:flutter/material.dart';
// import 'package:to_dos/LocalStorageService.dart';
// import 'package:to_dos/UserDetailScreen.dart';
// import 'api_service.dart';
// // import 'local_storage_service.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   late ApiService apiService;
//   late LocalStorageService localStorageService;
//   List<Map<String, dynamic>> users = [];

//   @override
//   void initState() {
//     super.initState();
//     apiService = ApiService();
//     localStorageService = LocalStorageService();
//     _loadUsers();
//   }

//   Future<void> _loadUsers() async {
//     try {
//       users = await apiService.fetchUsers();
//       await localStorageService.storeUsers(users);
//     } catch (e) {
//       users = await localStorageService.fetchUsersFromLocal();
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Users')),
//       body: ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             title: Text(user['name']),
//             subtitle: Text(user['email']),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => UserDetailScreen(user: user),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
