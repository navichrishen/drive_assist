// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// import '../../../common widgets/custom_appBar.dart';
// import '../../../common widgets/custom_button.dart';
// import '../../../common widgets/vehicle_scan_dialogWidget.dart';
// import '../../../common widgets/custom_myVehicle_container.dart';
// import '../../../constants/colors.dart';
// import '../../../constants/image_strings.dart';
// import '../../../constants/sizes.dart';
// import '../../../constants/text_strings.dart';
// import '../../models/vehicle.dart';
// import '../navigation/bottom_navBar.dart';
// import 'add_vehicle_screen.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../categories/map_layout_page.dart';
// import 'update_vehicle_scree.dart'; // Import the MapLayoutPage\

// class MyVehiclesScreen extends StatefulWidget {
//   @override
//   State<MyVehiclesScreen> createState() => _MyVehiclesScreenState();
// }

// class _MyVehiclesScreenState extends State<MyVehiclesScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   DatabaseReference? databaseRef;

//   User? _currentUser;

//   void _getCurrentUser() {
//     _currentUser = _auth.currentUser;
//   }

//   List<Vehicle> vehicles = [];

//   @override
//   void initState() {
//     super.initState();

//     _getCurrentUser();
//     fetchData(_currentUser!.uid);
//   }

//   Future<void> fetchData(String userId) async {
//     databaseRef = FirebaseDatabase.instance.ref('users/$userId/vehicles');
//     databaseRef!.onValue.listen((DatabaseEvent event) {
//       final data = event.snapshot.value;
//       print('data $data');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: "All Vehicles",
//         onLeadingPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
//           );
//         },
//       ),
//       body: FirebaseAnimatedList(
//           query: databaseRef!,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot,
//               Animation<double> animation, int index) {
//             Map vehicle = snapshot.value as Map;
//             vehicle['key'] = snapshot.key;

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: MyVehicleContainer(
//                 brand: vehicle['vehicleBrand'],
//                 model: vehicle['vehicleModel'],
//                 manufactureYear: vehicle['vehicleManufactureYear'],
//                 onDeletePressed: () {
//                   databaseRef!.child(vehicle['key']).remove().then((value) =>
//                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                           content: Text('Successfully deleted a vehicle'))));
//                 },
//                 onUpdatePressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             UpdateVehicleScreen(vehicleKey: vehicle['key'])),
//                   );
//                 },
//                 onScanPressed: () {
//                   _openMapLayout("Engine", vehicle['key']);
//                 },
//               ),
//             );
//           }),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddVehicleScreen()),
//           );
//         },
//         label: Text('Add New Vehicle'),
//         icon: Icon(Icons.add_circle_outline_sharp),
//         backgroundColor: const Color.fromARGB(255, 255, 204, 0),
//       ),
//     );
//   }

//   void _openMapLayout(String shopType, String vehicleKey) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => MapLayoutPage(
//                 shopType: shopType,
//                 linkKey: vehicleKey,
//               )),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';

import '../../../common widgets/custom_myVehicle_container.dart';

import '../../models/vehicle.dart';
import '../navigation/bottom_navBar.dart';
import 'add_vehicle_screen.dart';

import '../categories/map_layout_page.dart';
import 'update_vehicle_scree.dart';

class MyVehiclesScreen extends StatefulWidget {
  @override
  State<MyVehiclesScreen> createState() => _MyVehiclesScreenState();
}

class _MyVehiclesScreenState extends State<MyVehiclesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference? databaseRef;

  User? _currentUser;

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();

    _getCurrentUser();
    fetchData(_currentUser!.uid);
  }

  Future<void> fetchData(String userId) async {
    databaseRef = FirebaseDatabase.instance.ref('users/$userId/vehicles');
    databaseRef!.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print('data $data');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "All Vehicles",
        onLeadingPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
          );
        },
      ),
      body: FirebaseAnimatedList(
          query: databaseRef!,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map vehicle = snapshot.value as Map;
            vehicle['key'] = snapshot.key;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyVehicleContainer(
                brand: vehicle['vehicleBrand'],
                model: vehicle['vehicleModel'],
                manufactureYear: vehicle['vehicleManufactureYear'],
                onDeletePressed: () {
                  databaseRef!.child(vehicle['key']).remove().then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Successfully deleted a vehicle'))));
                },
                onUpdatePressed: () {
                  print(
                      "Vehicle to be updated: $vehicle"); // Print the vehicle object

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateVehicleScreen(
                            vehicle: vehicle.cast<String, dynamic>()),
                      ));
                },
                onScanPressed: () {
                  _openMapLayout("Engine", vehicle['key']);
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddVehicleScreen()),
          );
        },
        label: Text('Add New Vehicle'),
        icon: Icon(Icons.add_circle_outline_sharp),
        backgroundColor: const Color.fromARGB(255, 255, 204, 0),
      ),
    );
  }

  void _openMapLayout(String shopType, String vehicleKey) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MapLayoutPage(
                shopType: shopType,
                linkKey: vehicleKey,
              )),
    );
  }
}
