import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common widgets/custom_appBar.dart';
import '../../models/rating_model.dart';
import '../navigation/bottom_navBar.dart';
import '../ratings/servicizer_ratereview_screen.dart';
import '../ratings/view_all_ratings_screen.dart';

typedef FetchRatingFunction = Future<void> Function(dynamic stationId);
//typedef UpdateRatingCallback = void Function(double newRating);

class MapLayoutPage extends StatefulWidget {
  final String shopType;
  final String linkKey;

  MapLayoutPage({required this.shopType, required this.linkKey});

  @override
  _MapLayoutPageState createState() => _MapLayoutPageState();
}

class _MapLayoutPageState extends State<MapLayoutPage> {
  DatabaseReference stationsRef =
      FirebaseDatabase.instance.ref().child('stations');
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final MapController mapController = MapController();
  LatLng currentLocation = LatLng(51.509364, -0.128928);
  List<CustomMarker> stationMarkers = [];
  late double rating = 0;

  String? stationIdKey;
  List<Rating> _ratings = [];
  List<double> _totalRatings = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    fetchAndDisplayStationsForCategory(widget.shopType);
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      mapController.move(currentLocation, 15.0);
    });
  }

  // Future<void> _rateLocation(String key, double rating, String commet) async {
  //   stationsRef.child(key).update({'rating': rating, 'comment': commet});
  // }

  Future<void> _addRatingsToDB(
      double rating, String comment, String stationId) async {
    Map<String, dynamic> ratings = {
      'stationId': stationId,
      'rating': rating,
      'comment': comment
    };

    await _databaseReference.child('ratings').push().set(ratings).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Successfully added a ratings'))));
    Navigator.pop(context);
  }

  void fetchAndDisplayStationsForCategory(String category) {
    stationsRef.orderByChild('category').equalTo(category).onValue.listen(
        (event) {
      DataSnapshot snapshot = event.snapshot;

      Map<dynamic, dynamic>? stations =
          snapshot.value as Map<dynamic, dynamic>?;
      stations!['key'] = snapshot.key;

      print(stations);

      if (stations != null) {
        stations.forEach((key, value) {
          print(key);

          double latitude = value['latitude'];
          double longitude = value['longitude'];

          LatLng stationLocation = LatLng(latitude, longitude);

          CustomMarker stationMarker = buildPinMarker(
              stationLocation,
              key,
              value['name'],
              value['user'],
              value['cnumber'],
              fetchRatingsByStationId);
          setState(() {
            stationMarkers.add(stationMarker);
          });
        });
      } else {
        print('No stations found for the category: $category');
      }
    }, onError: (error) {
      print('Failed to fetch stations: $error');
    });
  }

  // Future<void> fetchRatingsByStationId(dynamic stationId) async {
  //   double val = 0.0;

  //   DatabaseReference reference =
  //       FirebaseDatabase.instance.ref().child('ratings');

  //   try {
  //     reference.orderByChild('stationId').equalTo(stationId).onValue.listen(
  //         (event) {
  //       if (event.snapshot.value != null) {
  //         _ratings.clear();
  //         _totalRatings.clear();
  //         rating = 0.0;

  //         Map<dynamic, dynamic>? ratings =
  //             event.snapshot.value as Map<dynamic, dynamic>?;
  //         if (ratings != null) {
  //           ratings.forEach((key, value) {
  //             setState(() {
  //               print('Comment: ${value['comment']}');
  //               print('Rating: ${value['rating']}');
  //               val = convertToDouble(value['rating']);

  //               _ratings.add(Rating(comment: value['comment'], rating: val));

  //               _totalRatings.add(val);
  //             });
  //           });

  //           print('this is the list${_ratings}');
  //           setState(() {
  //             // rating = calculateAverageRating(_totalRatings);
  //             calculateAverageRating(_totalRatings);
  //           });
  //           print('average rating - ${rating}');
  //         } else {
  //           print('No ratings found for station ID: $stationId');
  //         }
  //       }
  //     }, onError: (error) {
  //       _ratings.clear();
  //       _totalRatings.clear();
  //       rating = 0.0;

  //       print('Error fetching ratings: $error');
  //     });
  //   } catch (e) {}
  // }
  Future<void> fetchRatingsByStationId(dynamic stationId) async {
    double val = 0.0;

    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('ratings');

    try {
      reference.orderByChild('stationId').equalTo(stationId).onValue.listen(
          (event) {
        if (event.snapshot.value != null) {
          _ratings.clear();
          _totalRatings.clear();
          rating = 0.0;

          Map<dynamic, dynamic>? ratings =
              event.snapshot.value as Map<dynamic, dynamic>?;
          if (ratings != null) {
            ratings.forEach((key, value) {
              setState(() {
                print('Comment: ${value['comment']}');
                print('Rating: ${value['rating']}');
                val = convertToDouble(value['rating']);

                _ratings.add(Rating(comment: value['comment'], rating: val));

                _totalRatings.add(val);
              });
            });

            print('this is the list${_ratings}');
            setState(() {
              calculateAverageRating(_totalRatings);
            });
            print('average rating - ${rating}');
          } else {
            print('No ratings found for station ID: $stationId');
            // Add a default rating of 0
            _totalRatings.add(0.0);
            setState(() {
              calculateAverageRating(_totalRatings);
            });
          }
        }
      }, onError: (error) {
        setState(() {
          rating = 0.0;
        });

        _ratings.clear();
        _totalRatings.clear();
        print('Error fetching ratings: $error');
      });
    } catch (e) {}
  }

  // double calculateAverageRating(List<double> numbers) {
  //   double sum = numbers.reduce((value, element) => value + element);
  //   double result = (sum * 5.0) / 100;
  //   return result;
  // }
  void calculateAverageRating(List<double> ratings) {
    double adjustmentNeeded = 0;
    double currentAverage = ratings.isNotEmpty
        ? ratings.reduce((a, b) => a + b) / ratings.length
        : 0;

    if (currentAverage < 0) {
      adjustmentNeeded = currentAverage.abs();
    } else if (currentAverage > 5) {
      adjustmentNeeded = 5 - currentAverage;
    }

    List<double> adjustedRatings = ratings
        .map((rating) => (rating + adjustmentNeeded)
            .clamp(0, 5)
            .toDouble()) // Convert to double
        .toList();

    double adjustedAverage = adjustedRatings.isNotEmpty
        ? adjustedRatings.reduce((a, b) => a + b) / adjustedRatings.length
        : 0;
    adjustedAverage = double.parse(adjustedAverage.toStringAsFixed(1));
    print('Adjusted Average: $adjustedAverage');
    rating = adjustedAverage;
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

  void updateTotalRating(String stationKey, double newTotalRating) async {
    await stationsRef.child(stationKey).update({
      'total_rating': newTotalRating,
    });
  }

  showDynamicDialog({
    required BuildContext context,
    required String name,
    required String user,
    required String cnumber,
    required String stationId,
    required double rating,
    required String linkKey,
    required Function(double) setStateCallback,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(name),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Name: $name \nAdded By: $user \nContact Number: $cnumber \nRatings: $rating'),
                ),
                SizedBox(
                  height: 20,
                ),
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: rating,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setStateCallback(newRating);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  var updatedRating = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddRateAndReviewScreen(
                              linkKey: stationId,
                              addRatings: _addRatingsToDB,
                            )),
                  );
                },
                child: Text('Rate this Shop'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewRatings(
                                ratings: _ratings,
                              )));
                },
                child: Text('View ratings'),
              ),
              TextButton(
                onPressed: () {
                  Uri phoneNumber = Uri(scheme: "tel", path: cnumber);
                  launchUrl(phoneNumber);
                },
                child: Text('Call This Number'),
              ),
              TextButton(
                onPressed: () {
                  _totalRatings.clear();

                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Nearest Service Stations",
        onLeadingPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen()),
          );
        },
      ),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: currentLocation,
          zoom: 3.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.drive_assist',
          ),
          MarkerLayer(
            markers: [
              buildPinMarker(currentLocation, "Current Location",
                  "Current Location", "", "", fetchRatingsByStationId),
              ...stationMarkers,
            ],
          ),
        ],
      ),
    );
  }

  CustomMarker buildPinMarker(
    LatLng coordinates,
    dynamic stationId,
    String name,
    String user,
    String cnumber,
    FetchRatingFunction fetchRatingById,
  ) {
    return CustomMarker(
      point: coordinates,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () async {
            if (name != "Current Location") {
              print(' THIS IS THE STATTION ID : $stationId');
              await fetchRatingById(stationId);
              updateTotalRating(stationId, rating);

              //fetchRatingsByStationId(stationId);
              showDynamicDialog(
                  stationId: stationId,
                  context: context,
                  name: name,
                  user: user,
                  cnumber: cnumber,
                  rating: rating,
                  linkKey: widget.linkKey,
                  setStateCallback: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  });
            }
          },
          child: Container(
            child: Column(
              children: [
                Icon(
                  // location_pin for other markers
                  name == "Current Location"
                      ? Icons.directions_car
                      : Icons.location_pin,
                  color: name == "Current Location" ? Colors.blue : Colors.red,
                  size: 30.0,
                ),
                SizedBox(height: 5),
                Text(
                  name,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomMarker extends Marker {
  final WidgetBuilder builder;

  CustomMarker({
    required LatLng point,
    required this.builder,
  }) : super(
          point: point,
          width: 200,
          height: 120,
          builder: (BuildContext context) {
            return builder(context);
          },
        );
}
