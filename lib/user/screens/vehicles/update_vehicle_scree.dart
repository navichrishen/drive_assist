// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:drive_assist/constants/sizes.dart';

// import '../../../common widgets/custom_appBar.dart';
// import '../../../common widgets/custom_text_field.dart';
// import '../../../constants/image_strings.dart';
// import '../../../constants/text_strings.dart';
// import '../navigation/bottom_navBar.dart';
// import '../auth/user_login_screen.dart';

// class UpdateVehicleScreen extends StatefulWidget {
//   final String vehicleKey;

//   const UpdateVehicleScreen({Key? key, required this.vehicleKey})
//       : super(key: key);

//   @override
//   State<UpdateVehicleScreen> createState() => _UpdateVehicleScreenState();
// }

// class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   User? _currentUser;

//   late TextEditingController brandTextEditingController;
//   late TextEditingController modelTextEditingController;
//   late TextEditingController manuYearTextEditingController;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUser();
//     brandTextEditingController = TextEditingController();
//     modelTextEditingController = TextEditingController();
//     manuYearTextEditingController = TextEditingController();
//     _populateExistingData();
//   }

//   void _getCurrentUser() {
//     _currentUser = _auth.currentUser;
//   }

//   Future<void> _populateExistingData() async {
//     DataSnapshot dataSnapshot = await _database
//         .child('users/${_currentUser!.uid}/vehicles')
//         .child(widget.vehicleKey)
//         .once() as DataSnapshot;

//     if (dataSnapshot.value != null) {
//       Map<String, dynamic> vehicleData =
//           dataSnapshot.value as Map<String, dynamic>;
//       setState(() {
//         brandTextEditingController.text = vehicleData['vehicleBrand'] ?? '';
//         modelTextEditingController.text = vehicleData['vehicleModel'] ?? '';
//         manuYearTextEditingController.text =
//             vehicleData['vehicleManufactureYear'] ?? '';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         appBar: CustomAppBar(
//           title: apkUpdateVehicleAppBarTitle,
//           onLeadingPressed: () {},
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.all(apkDefaultSize),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: size.height * 0.22,
//                   child: Center(
//                     child: Image(
//                       image: AssetImage(apkLogo),
//                     ),
//                   ),
//                 ),
//                 Text(apkUpdateVehicleTitle,
//                     style: Theme.of(context).textTheme.displaySmall),
//                 const SizedBox(height: apkDefaultSize - 28),
//                 Text(apkUpdateVehicleSubTitle,
//                     style: Theme.of(context).textTheme.bodyLarge),
//                 const SizedBox(height: apkDefaultSize - 10),
//                 CustomTextField(
//                   controller: brandTextEditingController,
//                   labelText: apkBrandTxt,
//                   hintText: apkBrandHintTxt,
//                   prefixIcon: Icons.directions_car_sharp,
//                 ),
//                 const SizedBox(height: apkDefaultSize - 20),
//                 CustomTextField(
//                   controller: modelTextEditingController,
//                   labelText: apkModelTxt,
//                   hintText: apkModelHintTxt,
//                   prefixIcon: Icons.directions_car_sharp,
//                 ),
//                 const SizedBox(height: apkDefaultSize - 20),
//                 CustomTextField(
//                   controller: manuYearTextEditingController,
//                   keyboardType: TextInputType.number,
//                   labelText: apkManuYearTxt,
//                   hintText: apkManuYearHintTxt,
//                   prefixIcon: Icons.wifi_tethering_outlined,
//                 ),
//                 const SizedBox(height: apkDefaultSize - 20),
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       await updateVehicleInformation(_currentUser!.uid)
//                           .then((value) => Navigator.pop(context));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(255, 0, 29, 61),
//                       textStyle: TextStyle(color: Colors.white),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     child: Text(
//                       apkUpdateTxt.toUpperCase(),
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: apkDefaultSize - 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> updateVehicleInformation(String userId) async {
//     Map<String, dynamic> vehicleData = {
//       'vehicleBrand': brandTextEditingController.text.trim(),
//       'vehicleModel': modelTextEditingController.text.trim(),
//       'vehicleManufactureYear': manuYearTextEditingController.text.trim()
//     };

//     await _database
//         .child('users/$userId/vehicles')
//         .child(widget.vehicleKey)
//         .update(vehicleData)
//         .then((value) => ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Successfully updated a vehicle'))));
//   }
// }
import 'package:drive_assist/user/models/vehicle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:drive_assist/constants/sizes.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_text_field.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../navigation/bottom_navBar.dart';
import '../auth/user_login_screen.dart';

class UpdateVehicleScreen extends StatefulWidget {
  final Map<String, dynamic> vehicle;

  // Constructor to accept the vehicle object
  const UpdateVehicleScreen({Key? key, required this.vehicle})
      : super(key: key);
  @override
  State<UpdateVehicleScreen> createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? _currentUser;

  late TextEditingController brandTextEditingController;
  late TextEditingController modelTextEditingController;
  late TextEditingController manuYearTextEditingController;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    brandTextEditingController = TextEditingController();
    modelTextEditingController = TextEditingController();
    manuYearTextEditingController = TextEditingController();
    _populateExistingData();
  }

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  void _populateExistingData() {
    Map<String, dynamic> vehicleData = widget.vehicle;

    setState(() {
      brandTextEditingController.text = vehicleData['vehicleBrand'] ?? '';
      modelTextEditingController.text = vehicleData['vehicleModel'] ?? '';
      manuYearTextEditingController.text =
          vehicleData['vehicleManufactureYear'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: apkUpdateVehicleAppBarTitle,
          onLeadingPressed: () {},
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(apkDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height * 0.22,
                  child: Center(
                    child: Image(
                      image: AssetImage(apkLogo),
                    ),
                  ),
                ),
                Text(apkUpdateVehicleTitle,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: apkDefaultSize - 28),
                Text(apkUpdateVehicleSubTitle,
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: apkDefaultSize - 10),
                CustomTextField(
                  controller: brandTextEditingController,
                  labelText: apkBrandTxt,
                  hintText: apkBrandHintTxt,
                  prefixIcon: Icons.directions_car_sharp,
                ),
                const SizedBox(height: apkDefaultSize - 20),
                CustomTextField(
                  controller: modelTextEditingController,
                  labelText: apkModelTxt,
                  hintText: apkModelHintTxt,
                  prefixIcon: Icons.directions_car_sharp,
                ),
                const SizedBox(height: apkDefaultSize - 20),
                CustomTextField(
                  controller: manuYearTextEditingController,
                  keyboardType: TextInputType.number,
                  labelText: apkManuYearTxt,
                  hintText: apkManuYearHintTxt,
                  prefixIcon: Icons.wifi_tethering_outlined,
                ),
                const SizedBox(height: apkDefaultSize - 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await updateVehicleInformation(_currentUser!.uid)
                          .then((value) => Navigator.pop(context));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                      textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      apkUpdateTxt.toUpperCase(),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: apkDefaultSize - 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateVehicleInformation(String userId) async {
    Map<String, dynamic> vehicleData = {
      'vehicleBrand': brandTextEditingController.text.trim(),
      'vehicleModel': modelTextEditingController.text.trim(),
      'vehicleManufactureYear': manuYearTextEditingController.text.trim()
    };

    await _database
        .child('users/$userId/vehicles')
        .child(widget.vehicle['key'])
        .update(vehicleData)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully updated a vehicle'))));
  }
}
