import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:drive_assist/constants/sizes.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_text_field.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import 'dart:developer' as developer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: AddServiceStatioScreen()));
}

class AddServiceStatioScreen extends StatefulWidget {
  const AddServiceStatioScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceStatioScreen> createState() => _AddServiceStatioScreenState();
}

class _AddServiceStatioScreenState extends State<AddServiceStatioScreen> {
  final TextEditingController stationNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  LatLng? selectedLocation;
  late String userEmail = '';

  @override
  void initState() {
    super.initState();
    getUserEmail().then((email) {
      setState(() {
        userEmail = email;
      });
    });
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Service Station",
        onLeadingPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
          // );
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: stationNameController,
              labelText: "Station",
              hintText: "Enter Station Name",
              prefixIcon: Icons.directions_car_sharp,
            ),
            const SizedBox(height: apkDefaultSize - 20),
            // TextField(
            //   controller: stationNameController,
            //   decoration: InputDecoration(
            //     labelText: "Station",
            //     hintText: "Enter Station Name",
            //     prefixIcon: Icon(Icons.local_gas_station),
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            CustomTextField(
              controller: locationController,
              labelText: "Colombo 3' Armour Street",
              hintText: "Enter Location",
              prefixIcon: Icons.location_on_outlined,
            ),
            const SizedBox(height: apkDefaultSize - 20),
            // TextField(
            //   controller: locationController,
            //   decoration: InputDecoration(
            //     labelText: "Colombo 3' Armour Street",
            //     hintText: "Enter Location",
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            CustomTextField(
              controller: categoryController,
              labelText: "Enter Category of Shop",
              hintText: "Enter Category of Shop",
              prefixIcon: Icons.category_outlined,
            ),
            const SizedBox(height: apkDefaultSize - 20),
            // TextField(
            //   controller: categoryController,
            //   decoration: InputDecoration(
            //     labelText: "Enter Category of Shop",
            //     hintText: "Enter Category of Shop",
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            CustomTextField(
              controller: numberController,
              labelText: "Enter Contact Number of Shop",
              hintText: "Enter Contact Number of Shop",
              prefixIcon: Icons.phone_enabled_outlined,
            ),
            const SizedBox(height: apkDefaultSize - 20),
            // TextField(
            //   controller: numberController,
            //   decoration: InputDecoration(
            //     labelText: "Enter Contact Number of Shop",
            //     hintText: "Enter Category of Shop",
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: apkDefaultSize - 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _selectLocation(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                  textStyle: TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Select Location on Map".toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: apkDefaultSize - 20),
            if (selectedLocation != null)
              Text(
                  "Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}"),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () => _selectLocation(context),
            //   child: Text("Select Location on Map"),
            // ),
            const SizedBox(height: apkDefaultSize - 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _addServiceStation(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                  textStyle: TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  "Add Service Station".toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: apkDefaultSize - 20),
            // ElevatedButton(
            //   onPressed: () => _addServiceStation(),
            //   child: Text("Add Service Station"),
            // ),
            // if (selectedLocation != null)
            //   Text(
            //       "Location: ${selectedLocation!.latitude}, ${selectedLocation!.longitude}"),
          ],
        ),
      ),
    );
  }

  void _selectLocation(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPickerScreen()),
    );

    if (result != null) {
      setState(() {
        selectedLocation = result as LatLng;
      });
    }
  }

  final DatabaseReference stationsRef =
      FirebaseDatabase.instance.ref().child('stations');

  void _addServiceStation() async {
    if (selectedLocation == null ||
        stationNameController.text.isEmpty ||
        locationController.text.isEmpty ||
        categoryController.text.isEmpty ||
        numberController.text.isEmpty) {
      print("Error: Please enter all detailss");
      _showErrorDialog("Please enter all details.");
      return;
    }

    DatabaseReference newStationRef = stationsRef.push();

    Map<String, dynamic> stationData = {
      'name': stationNameController.text.trim(),
      'latitude': selectedLocation!.latitude,
      'longitude': selectedLocation!.longitude,
      'user': userEmail,
      'location': locationController.text.trim(),
      'category': categoryController.text.trim(),
      'cnumber': numberController.text.trim(),
    };

    print("Before set operation");

    try {
      await newStationRef.set(stationData);
      print("Set operation completed successfully");
      _showSuccessDialog("Station added successfully");
    } catch (error) {
      print("Error during set operation: $error");
      _showErrorDialog("Failed to add station: $error");
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Success"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}

class MapPickerScreen extends StatefulWidget {
  @override
  _MapPickerScreenState createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  final MapController mapController = MapController();
  LatLng currentLocation = LatLng(51.509364, -0.128928);
  late String userEmail;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      mapController.move(currentLocation, 15.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select Location",
        onLeadingPressed: () {},
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentLocation,
          zoom: 13.0,
          onTap: (_, latlng) {
            setState(() {
              currentLocation = latlng;
            });
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.drive_assist',
          ),
          MarkerLayer(
            markers: [
              buildPinMarker(currentLocation),
              buildTextMarker(currentLocation, "Current Location"),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (currentLocation != null) {
            Navigator.pop(context, currentLocation);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Container buildTextWidget(String word) {
    return Container(
        alignment: Alignment.center,
        child: Text(word,
            textAlign: TextAlign.center, style: getDefaultTextStyle()));
  }

  TextStyle getDefaultTextStyle() {
    return const TextStyle(
      fontSize: 12,
      backgroundColor: Colors.black,
      color: Colors.white,
    );
  }

  Marker buildTextMarker(LatLng coordinates, String word) {
    return Marker(
        point: coordinates,
        width: 200,
        height: 120,
        builder: (context) => buildTextWidget(word));
  }

  Marker buildPinMarker(LatLng coordinates) {
    return Marker(
      point: coordinates,
      width: 50,
      height: 50,
      builder: (context) => Container(
        child: Icon(
          Icons.location_pin, // Use a custom icon here
          color: Colors.red, // Set the color of the icon
          size: 50.0,
        ),
      ),
    );
  }
}
