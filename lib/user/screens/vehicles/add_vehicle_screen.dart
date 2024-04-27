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

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  User? _currentUser;

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
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
                Text(apkAddVehicleTitle,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: apkDefaultSize - 28),
                Text(apkAddVehicleSubTitle,
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
                    onPressed: () {
                      _storeVehicleUser(
                          brandTextEditingController.text,
                          modelTextEditingController.text,
                          manuYearTextEditingController.text,
                          _currentUser!.uid);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                      textStyle: TextStyle(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      apkAddTxt.toUpperCase(),
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

  // controolers
  final TextEditingController brandTextEditingController =
      TextEditingController();
  final TextEditingController modelTextEditingController =
      TextEditingController();
  final TextEditingController manuYearTextEditingController =
      TextEditingController();

  // DatabaseReference vehicleRef = FirebaseDatabase.instance.ref("vehicles");

  // void _storeNewVehicle() {
  //   var newVehicleRef = vehicleRef.push();
  //   String? id = newVehicleRef.key;

  //   Map<String, dynamic> vehicleData = {
  //     'vehicleBrand': brandTextEditingController.text.trim(),
  //     'vehicleModel': modelTextEditingController.text.trim(),
  //     'vehicleManufactureYear': manuYearTextEditingController.text.trim(),
  //     'id': id,
  //   };

  //   vehicleRef.set(vehicleData);

  //   Navigator.pop(context);
  // }

  Future<void> _storeVehicleUser(
      String brand, String model, String year, String userId) async {
    Map<String, dynamic> vehicleData = {
      'vehicleBrand': brandTextEditingController.text.trim(),
      'vehicleModel': modelTextEditingController.text.trim(),
      'vehicleManufactureYear': manuYearTextEditingController.text.trim()
    };

    await _database
        .child('users/$userId/vehicles')
        .push()
        .set(vehicleData)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully added a vehicle'))));
    Navigator.pop(context);

    //if(_currentUser!=null && )
  }
}
