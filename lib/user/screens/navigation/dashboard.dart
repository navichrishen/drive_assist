import 'dart:async';

import 'package:drive_assist/user/providers/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../common widgets/vehicle_scan_dialogWidget.dart';
import '../../../constants/text_strings.dart';
import '../vehicles/add_vehicle_screen.dart';
import '../categories/brakeIssues_selection_screen.dart';
import '../categories/electricaIssues_selection_screen.dart';
import '../categories/engineIssues_selection_screen.dart';
import '../auth/user_registration_screen.dart';
import '../categories/safetyIssues_selection_screen.dart';
import 'settings_screen.dart';
import '../categories/tireIssues_selection_screen.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List catName = [
    "Engine Issues",
    "Brake Issues",
    "Tire Issues",
    "Electrical Issues",
    "Safety Issues",
  ];

  List<Color> catColors = [
    Color.fromARGB(255, 0, 53, 102),
    Color.fromARGB(255, 26, 73, 117),
    Color.fromARGB(255, 51, 93, 133),
    Color.fromARGB(255, 77, 114, 148),
    Color.fromARGB(255, 102, 134, 163),
  ];

  List<Icon> catIcon = [
    Icon(Icons.energy_savings_leaf_rounded, color: Colors.white, size: 30),
    Icon(Icons.bookmarks_outlined, color: Colors.white, size: 30),
    Icon(Icons.car_repair_outlined, color: Colors.white, size: 30),
    Icon(Icons.car_rental, color: Colors.white, size: 30),
    Icon(Icons.car_crash_outlined, color: Colors.white, size: 30),
  ];

  List imgList = [
    'ABS',
    'check engine',
    'ck battery',
    'oil p',
    'ABS',
    'check engine',
    'ck battery',
    'oil p',
    'ABS',
    'check engine',
  ];

  List physicalImgList = [
    'ABS',
    'check engine',
    'ck battery',
    'oil p',
    'ABS',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 29, 61),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Fixed part
            Container(
              padding:
                  EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 29, 61),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //dashboard header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.dashboard,
                        size: 30,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.notifications_active,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Text(
                      apkDashboardWelcomeTitle + UserInstance().firstName!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: apkDashboardSearch,
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable part(dashboard body)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            apkDashboardCategoriesTitle,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        // category grid
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: GridView.builder(
                            itemCount: catName.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.1,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      // Navigate to screen for category 1
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EngineIssuesSelectionScreen()),
                                      );
                                      break;
                                    case 1:
                                      // Navigate to screen for category 2
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BrakeIssuesSelectionScreen()),
                                      );
                                      break;
                                    case 2:
                                      // Navigate to screen for category 2
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TireIssuesSelectionScreen()),
                                      );
                                      break;
                                    case 3:
                                      // Navigate to screen for category 2
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ElectricalIssuesSelectionScreen()),
                                      );
                                      break;
                                    case 4:
                                      // Navigate to screen for category 2
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SafetyIssuesSelectionScreen()),
                                      );
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: catColors[index],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: catIcon[index],
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Expanded(
                                      child: Text(
                                        catName[index],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                apkDashboardServicesTitleOne,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        // Services (Dashboard Warnings)
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: imgList.map((item) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                              255, 102, 134, 163)
                                          .withOpacity(0.3),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/images/$item.png",
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                apkDashboardServicesTitleTwo,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        // Services(Physical failure)
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, bottom: 80, left: 15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: physicalImgList.map((item) {
                                return InkWell(
                                  onTap: () {},
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 40),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                              255, 102, 134, 163)
                                          .withOpacity(0.3),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            "assets/images/$item.png",
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          item,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (context) => const CustomDialogWidget());
      //   },
      //   child: Icon(Icons.camera_alt, color: Colors.white),
      //   backgroundColor: const Color.fromARGB(255, 255, 195, 0),

      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const CustomDialogWidget());
        },
        label: const Text('Scan Here', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 255, 204, 0),
      ),
    );
  }
}
