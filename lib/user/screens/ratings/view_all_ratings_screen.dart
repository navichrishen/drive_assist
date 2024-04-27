import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../constants/colors.dart';
import '../../models/rating_model.dart';

class ViewRatings extends StatefulWidget {
  //String stationId;
  List<Rating> ratings;
  ViewRatings({super.key, required this.ratings});

  @override
  State<ViewRatings> createState() => _ViewRatingsState();
}

class _ViewRatingsState extends State<ViewRatings> {
  final DatabaseReference _ratingsRef =
      FirebaseDatabase.instance.ref().child('ratings');
  List<Rating> _ratings = [];
  List<int> _totalRatings = [];

  // @override
  // void initState() {
  //   super.initState();

  //   fetchRatingsByStationId(widget.stationId);
  // }

  // _onRatingSelected(double rating) {
  //   Navigator.pop(context, rating);
  // }

  // double calculateWeightedAverageRating(List<int> numbers) {
  //   List<int> weights = [5, 4, 3, 2, 1];

  //   int weightedSum = 0;
  //   int totalWeight = 0;
  //   for (int i = 0; i < numbers.length; i++) {
  //     weightedSum += numbers[i] * weights[i];
  //     totalWeight += weights[i];
  //   }

  //   // Calculate the weighted average
  //   double result = weightedSum / totalWeight.toDouble();

  //   return result;
  // }

  // void fetchRatingsByStationId(String stationId) {
  //   DatabaseReference reference =
  //       FirebaseDatabase.instance.ref().child('ratings');

  //   reference.orderByChild('stationId').equalTo(stationId).onValue.listen(
  //       (event) {
  //     if (event.snapshot.value != null) {
  //       _ratings.clear();

  //       Map<dynamic, dynamic>? ratings =
  //           event.snapshot.value as Map<dynamic, dynamic>?;
  //       if (ratings != null) {
  //         ratings.forEach((key, value) {
  //           setState(() {
  //             _ratings.add(
  //                 Rating(comment: value['comment'], rating: value['rating']));
  //             _totalRatings.add(value['rating']);
  //           });
  //           print('this is the list${_ratings}');
  //         });
  //       } else {
  //         print('No ratings found for station ID: $stationId');
  //       }
  //     }
  //   }, onError: (error) {
  //     print('Error fetching ratings: $error');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "View Ratings",
        onLeadingPressed: () {
          // double rating = calculateAverageRating(_totalRatings);
          // _onRatingSelected(rating);
          Navigator.of(context).pop();
        },
      ),
      body: widget.ratings.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: widget.ratings.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: AppColor.apkPrimaryTxt,
                    child: ListTile(
                      title: Column(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: widget.ratings[index].rating,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (newRating) {},
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(' ${widget.ratings[index].comment}'),
                        ],
                      ),
                      // You can add more UI elements to display other rating details
                    ),
                  ),
                );
              },
            ),
    );
  }
}
