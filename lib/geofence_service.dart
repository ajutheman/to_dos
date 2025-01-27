// import 'package:geofence_service/geofence_service.dart';

// class GeoFencingService {
//   // Assuming GeofenceService requires an 'id' during initialization
//   // Replace with the correct initialization method according to your package documentation
//   final GeofenceService _geofenceService = GeofenceService(id: "your_unique_id");

//   // Setup the Geofence with proper parameters
//   void setupGeoFence(double lat, double lon, double radius) {
//     // Create a geofence object with the correct parameters
//     _geofenceService.addGeofence(
//       Geofence(
//         id: "unique_geofence_id",  // Unique ID for each geofence
//         latitude: lat,
//         longitude: lon,
//         // Make sure radius is wrapped correctly if needed
//         radius: [GeofenceRadius(radius)],  // Wrap radius in a List
//         // Assuming the correct parameters are 'onEnter' and 'onExit' or similar
//         onEnter: () {
//           print('Entered geofence');
//         },
//         onExit: () {
//           print('Exited geofence');
//         },
//       ),
//     );
//   }

//   // Start geofencing by monitoring the geofences
//   void startGeoFencing() {
//     // Check the actual method provided by your geofence package (this is just an assumption)
//     _geofenceService.startMonitoringGeofences();
//   }

//   // Stop geofencing
//   void stopGeoFencing() {
//     // Check the actual method provided by your geofence package (this is just an assumption)
//     _geofenceService.stopMonitoringGeofences();
//   }
// }
