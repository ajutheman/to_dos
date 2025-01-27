// import 'package:flutter/material.dart';
// import 'package:to_dos/LocalStorageService.dart';
// import 'package:to_dos/LocationService.dart';
// import 'package:to_dos/geofence_service.dart';
// // import 'location_service.dart';
// // import 'geo_fencing_service.dart';
// import 'api_service.dart';
// // import 'local_storage_service.dart';

// class UserDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> user;

//   UserDetailScreen({required this.user});

//   @override
//   _UserDetailScreenState createState() => _UserDetailScreenState();
// }

// class _UserDetailScreenState extends State<UserDetailScreen> {
//   late LocationService locationService;
//   late GeoFencingService geoFencingService;
//   late ApiService apiService;
//   late LocalStorageService localStorageService;
//   double distance = 0.0;
//   String geoFenceStatus = 'Unknown';
//   List<Map<String, dynamic>> todos = [];

//   @override
//   void initState() {
//     super.initState();
//     locationService = LocationService();
//     geoFencingService = GeoFencingService();
//     apiService = ApiService();
//     localStorageService = LocalStorageService();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     try {
//       todos = await apiService.fetchTodos(widget.user['id']);
//       await localStorageService.storeTodos(widget.user['id'], todos);
//     } catch (e) {
//       todos = await localStorageService.fetchTodosFromLocal(widget.user['id']);
//     }
//     _fetchCurrentLocation();
//   }

//   Future<void> _fetchCurrentLocation() async {
//     try {
//       final position = await locationService.getCurrentLocation();
//       distance = locationService.calculateDistance(
//         widget.user['address']['geo']['lat'],
//         widget.user['address']['geo']['lng'],
//         position.latitude,
//         position.longitude,
//       );
//       setState(() {});
//     } catch (e) {
//       print("Error fetching location: $e");
//     }
//   }

//   void _setupGeoFence() {
//     geoFencingService.setupGeoFence(
//       widget.user['address']['geo']['lat'],
//       widget.user['address']['geo']['lng'],
//       500,
//     );
//     geoFencingService.startGeoFencing();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.user['name'])),
//       body: Column(
//         children: [
//           Text('Distance from user: ${distance.toStringAsFixed(2)} meters'),
//           ElevatedButton(
//             onPressed: _setupGeoFence,
//             child: Text('Set Geo-fence'),
//           ),
//           Text('Geo-fence status: $geoFenceStatus'),
//           Expanded(
//             child: ListView.builder(
//               itemCount: todos.length,
//               itemBuilder: (context, index) {
//                 final todo = todos[index];
//                 return ListTile(
//                   title: Text(todo['title']),
//                   subtitle: Text(todo['completed'] ? 'Completed' : 'Pending'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
