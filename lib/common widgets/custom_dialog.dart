import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../user/screens/ratings/servicizer_ratereview_screen.dart';

class CustomAlertDialog extends StatelessWidget {
  final String name;
  final String user;
  final String cnumber;
  String? linkKey;
  double rating;
  VoidCallback setStateCallback;

  CustomAlertDialog(
      {required this.name,
      required this.user,
      required this.cnumber,
      required this.rating,
      required this.setStateCallback,
      this.linkKey});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Name: $name \nAdded By: $user \nContact Number: $cnumber \nRatings: $rating',
            ),
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
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            // Navigator.of(context).pop();

            // var updatedRating = await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AddRateAndReviewScreen(
            //       linkKey: linkKey!,
            //     ),
            //   ),
            // );
            // if (updatedRating != null) {
            //   rating = updatedRating;
            // }
          },
          child: Text('Rate this Shop'),
        ),
        TextButton(
          onPressed: () {
            Uri phoneNumber = Uri(scheme: "tel", path: cnumber);
            launchUrl(phoneNumber);
          },
          child: Text('Call This Number'),
        ),
        TextButton(
          onPressed: setStateCallback,
          child: Text('Close'),
        ),
      ],
    );
  }
}
