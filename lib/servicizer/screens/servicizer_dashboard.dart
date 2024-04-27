// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// import '../../../common widgets/vehicle_scan_dialogWidget.dart';
// import '../../../constants/text_strings.dart';
// import '../../common widgets/custom_serviceStation_container.dart';
// import '../../constants/sizes.dart';
// import 'add_serviceStation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/foundation.dart';

// class ServicizerDashboardScreen extends StatefulWidget {
//   ServicizerDashboardScreen({super.key});

//   @override
//   State<ServicizerDashboardScreen> createState() =>
//       _ServicizerDashboardScreenState();
// }

// class _ServicizerDashboardScreenState extends State<ServicizerDashboardScreen> {
//   List<Widget> serviceStationWidgets = [];
//   late String userEmail = '';

//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }

//   void _initializeData() async {
//     await getUserEmail().then((email) async {
//       userEmail = email;
//       fetchAndDisplayStationsForUser(userEmail);
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<String> getUserEmail() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('user_email') ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(20.0),
//         child: AppBar(
//           backgroundColor: const Color.fromARGB(255, 0, 29, 61),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Fixed part
//             Container(
//               padding:
//                   EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 0, 29, 61),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   //dashboard header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         Icons.dashboard,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                       Icon(
//                         Icons.notifications_active,
//                         size: 30,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.only(left: 3, bottom: 15),
//                     child: Text(
//                       apkDashboardWelcomeTitle,
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 1,
//                         wordSpacing: 2,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 3, bottom: 15),
//                     child: Text(
//                       "Servicizer Dashboard",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 1,
//                         wordSpacing: 2,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: apkDefaultSize - 20),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50, // Increased height
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   const AddServiceStatioScreen()),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         textStyle: const TextStyle(color: Colors.white),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: Text(
//                         "Add New Service Station",
//                         style: const TextStyle(
//                             fontSize: 16,
//                             color: Color.fromARGB(255, 0, 29, 61)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: apkDefaultSize),
//                 ],
//               ),
//             ),
//             // Scrollable part(dashboard body)
//             Expanded(
//               child: ListView.builder(
//                 itemCount: serviceStationWidgets.length +
//                     2, // 2 for the header row and spacer
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     // Header row
//                     return Row(
//                       children: <Widget>[
//                         _detailsCard('Services Stations', '1',
//                             const Color.fromARGB(255, 51, 93, 133)),
//                         // _detailsCard('Services Done', '10', const Color.fromARGB(255, 102, 134, 163)),
//                       ],
//                     );
//                   } else if (index == 1) {
//                     // Spacer
//                     return SizedBox(height: apkDefaultSize);
//                   } else {
//                     // Service station widgets
//                     return serviceStationWidgets[index - 2];
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Expanded _detailsCard(String title, String count, Color color) {
//     return Expanded(
//       child: Container(
//         margin: const EdgeInsets.all(8.0),
//         padding: const EdgeInsets.all(10.0),
//         height: 100,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 15.0,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Text(
//               count,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void fetchAndDisplayStationsForUser(String userEmail) {
//     DatabaseReference stationsRef =
//         FirebaseDatabase.instance.ref().child('stations');

//     stationsRef.orderByChild('user').equalTo(userEmail).onValue.listen((event) {
//       DataSnapshot snapshot = event.snapshot;
//       Map<dynamic, dynamic>? stations =
//           snapshot.value as Map<dynamic, dynamic>?; // Explicit casting

//       if (stations != null) {
//         stations.forEach((key, value) {
//           ServiceStationContainer stationContainer = ServiceStationContainer(
//             name: value['name'],
//             location: value['location'],
//             rating: '4.5',
//             onDeletePressed: () {},
//             // onUpdatePressed: () {},
//           );

//           setState(() {
//             serviceStationWidgets.add(stationContainer);
//           });
//         });
//       } else {
//         print('No stations found for the user.');
//       }
//     }, onError: (error) {
//       print('Failed to fetch stations: $error');
//     });
//   }
// }
import 'dart:async';

import 'package:drive_assist/user/providers/user.dart';
import 'package:drive_assist/user/screens/ratings/view_all_ratings_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../common widgets/vehicle_scan_dialogWidget.dart';
import '../../../constants/text_strings.dart';
import '../../common widgets/custom_serviceStation_container.dart';
import '../../constants/sizes.dart';
import '../../user/models/rating_model.dart';
import '../providers/servicizer.dart';
import 'add_serviceStation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ServicizerDashboardScreen extends StatefulWidget {
  ServicizerDashboardScreen({super.key});

  @override
  State<ServicizerDashboardScreen> createState() =>
      _ServicizerDashboardScreenState();
}

class _ServicizerDashboardScreenState extends State<ServicizerDashboardScreen> {
  List<Widget> serviceStationWidgets = [];
  late String userEmail = '';
  String firstName = '';
  int totalServiceStations = 0;

  List<Rating> ratingsAndReviews = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await getUserEmail().then((email) async {
      userEmail = email;

      fetchAndDisplayStationsForUser(userEmail);
      setState(() {});
    });
    await getUserDetails().then((username) async {
      firstName = username;

      // fetchAndDisplayStationsForUser(userEmail);
      // setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email') ?? '';
  }

  Future<String> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name') ?? '';
  }

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
                      apkDashboardWelcomeTitle + firstName!,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 15),
                    child: Text(
                      "Servicizer Dashboard",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        wordSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: apkDefaultSize - 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50, // Increased height
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddServiceStatioScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Add New Service Station",
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 29, 61)),
                      ),
                    ),
                  ),
                  const SizedBox(height: apkDefaultSize),
                ],
              ),
            ),
            // Scrollable part(dashboard body)
            Expanded(
              child: ListView.builder(
                itemCount: serviceStationWidgets.length +
                    2, // 2 for the header row and spacer
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Header row
                    return Row(
                      children: <Widget>[
                        _detailsCard(
                            'Services Stations',
                            totalServiceStations.toString(),
                            const Color.fromARGB(255, 51, 93, 133)),
                        // _detailsCard('Services Done', '10', const Color.fromARGB(255, 102, 134, 163)),
                      ],
                    );
                  } else if (index == 1) {
                    // Spacer
                    return SizedBox(height: apkDefaultSize);
                  } else {
                    // Service station widgets
                    return serviceStationWidgets[index - 2];
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _detailsCard(String title, String count, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double convertToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      throw ArgumentError('Value must be either int or double');
    }
  }

  void fetchAndDisplayStationsForUser(String userEmail) {
    DatabaseReference stationsRef =
        FirebaseDatabase.instance.ref().child('stations');

    stationsRef.orderByChild('user').equalTo(userEmail).onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? stations =
          snapshot.value as Map<dynamic, dynamic>?;

      if (stations != null) {
        // Update the totalServiceStations count dynamically
        setState(() {
          totalServiceStations = stations.length;
        });

        stations.forEach((key, value) {
          double val = 0.0;

          val = convertToDouble(value['total_rating'] ?? 0);
          ServiceStationContainer stationContainer = ServiceStationContainer(
              name: value['name'],
              location: value['location'],
              rating: val,
              onDeletePressed: () {
                print('hi');
              },
              onViewReviewsPressed: () {
                fetchRatingsByStationId(key);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewRatings(ratings: ratingsAndReviews)));
              }
              // onUpdatePressed: () {},
              );

          setState(() {
            serviceStationWidgets.add(stationContainer);
          });
        });
      } else {
        print('No stations found for the user.');
      }
    }, onError: (error) {
      print('Failed to fetch stations: $error');
    });
  }

  Future<void> fetchRatingsByStationId(dynamic stationId) async {
    double val = 0.0;

    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('ratings');

    reference.orderByChild('stationId').equalTo(stationId).onValue.listen(
        (event) {
      if (event.snapshot.value != null) {
        ratingsAndReviews.clear();

        Map<dynamic, dynamic>? ratings =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (ratings != null) {
          ratings.forEach((key, value) {
            setState(() {
              print('Comment: ${value['comment']}');
              print('Rating: ${value['rating']}');
              val = convertToDouble(value['rating']);
              ratingsAndReviews
                  .add(Rating(comment: value['comment'], rating: val));
            });
          });

          setState(() {
            // rating = calculateAverageRating(_totalRatings);
            // calculateAverageRating(_totalRatings);
          });
          print('average rating ');
        } else {
          print('No ratings found for station ID: $stationId');
        }
      }
    }, onError: (error) {
      print('Error fetching ratings: $error');
    });
  }
}
