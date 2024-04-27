import 'dart:convert';
import 'dart:io';

import 'package:drive_assist/common%20widgets/dialogs.dart';
import 'package:drive_assist/common%20widgets/imageConverter.dart';
import 'package:drive_assist/common%20widgets/server_config.dart';
import 'package:drive_assist/models/detection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/sizes.dart';
import '../user/screens/vehicles/add_vehicle_screen.dart';
import '../user/screens/reports/scanReport_screen.dart';
import 'custom_dropDown.dart';
import 'package:http/http.dart' as http;

class CustomDialogWidget extends StatefulWidget {
  const CustomDialogWidget({super.key});

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        children: [
          VehicleScanDialog(),
        ],
      ),
    );
  }
}

class VehicleScanDialog extends StatefulWidget {
  VehicleScanDialog({
    super.key,
  });

  @override
  State<VehicleScanDialog> createState() => _VehicleScanDialogState();
}

class _VehicleScanDialogState extends State<VehicleScanDialog> {
  String? valuesChoose;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference? databaseRef;

  List<String> listItem = [];
  User? _currentUser;

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  @override
  void initState() {
    print("hello");
    super.initState();

    _getCurrentUser();
    fetchData(_currentUser!.uid);
  }

  Future<void> fetchData(String userId) async {
    databaseRef = FirebaseDatabase.instance.ref('users/$userId/vehicles');
    databaseRef!.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      print('data $data');

      if (data != null && data is Map) {
        List<String> vehicleBrands = [];
        data.forEach((key, value) {
          if (value is Map && value.containsKey('vehicleBrand')) {
            vehicleBrands.add(value['vehicleBrand']);
          }
        });
        setState(() {
          listItem = vehicleBrands;
        });
        print('Vehicle Brands: $vehicleBrands');
      } else {
        print('No data available or data is not in the expected format');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.car_crash,
            size: 48, // Increase the size
            color: Colors.red, // Change the color
          ),
          const SizedBox(height: apkDefaultSize - 20),
          Text(
            "Ready To Scan",
            style: TextStyle(
              fontSize: 24,
              color: const Color.fromARGB(255, 0, 29, 61),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: apkDefaultSize - 20),
          Text(
            "Choose the vehicle that you would want to scan.",
            // textAlign: TextAlign.center,
            style: TextStyle(
              // fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: apkDefaultSize - 20),
          // vehicle selection dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                hint: Text("Choose a Vehicle"),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                value: valuesChoose,
                onChanged: (newValue) {
                  setState(() {
                    valuesChoose = newValue;
                  });
                },
                items: listItem.map((valueItem) {
                  return DropdownMenuItem<String>(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddVehicleScreen()),
                  );
                },
                child: const Text("Add Vehicle")),
          ),
          const SizedBox(height: apkDefaultSize - 20),
          Text(
            "What type of breakdown have you faced?",
            // textAlign: TextAlign.center,
            style: TextStyle(
              // fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: apkDefaultSize - 20),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                foregroundColor: const Color.fromARGB(255, 0, 29, 61),
                side: BorderSide(
                  color: const Color.fromARGB(255, 0, 29, 61),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                onCapturePress(DASHBOARD_API);
              },
              child: Text('Dashboard Warning'),
            ),
          ),
          const SizedBox(height: apkDefaultSize - 20),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                onCapturePress(PHYSICAL_API);
              },
              child: Text('Physical Failure'),
            ),
          ),
          const SizedBox(height: apkDefaultSize - 20),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close")),
          ),
        ],
      ),
    );
  }

  void onCapturePress(Uri API_TYPE) async {
    final ImagePicker _picker = ImagePicker();
    // Capture an image
    ImageSource? source = await showChoiceDialog(context);

    // Capture an image
    if (source != null) {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        File imageFile = File(image.path);
        // Convert image to base64
        String base64Str = await imageToBase64(imageFile);
        // Show loading dialog
        loadingDialog(context);
        try {
          await sendImageToServer(base64Str, API_TYPE);
        } catch (e) {
          Navigator.of(context).pop();
          print(e.toString());
          dismissDialog(context, 'Error', e.toString());
        }
      }
    }
  }

  // Function to send image to server
  Future<void> sendImageToServer(String base64Image, Uri API) async {
    var response = await http.post(
      API,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'image_base64': base64Image}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      handleServerResponse(data);
    } else {
      Navigator.of(context).pop();
      dismissDialog(context, 'Error', response.body);
    }
  }

  // Function to handle server response
  void handleServerResponse(Map<String, dynamic> data) {
    DetectionResponse response = DetectionResponse.fromJson(data);

    if (response.detections.isEmpty) {
      Navigator.of(context).pop();
      dismissDialog(context, 'Oops!', 'Nothing detected');
      return;
    }
    // navigate to another screen if needed
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScanReportScreen(
                response: response,
              )),
    );
  }
}
