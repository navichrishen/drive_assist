import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:drive_assist/constants/sizes.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../constants/image_strings.dart';

class AddRateAndReviewScreen extends StatefulWidget {
  final String linkKey;
  //final Function(String, double, String) rateLocationCallback;

  final Function(double, String, String) addRatings;

  const AddRateAndReviewScreen(
      {Key? key, required this.linkKey, required this.addRatings})
      : super(key: key);

  @override
  State<AddRateAndReviewScreen> createState() => _AddRateAndReviewScreenState();
}

class _AddRateAndReviewScreenState extends State<AddRateAndReviewScreen> {
  double _userRating = 0.0;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController commentController = TextEditingController();

  User? _currentUser;

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  // Future<void> _rateVehicle(
  //     String vehicleKey, double rating, String commet, String userId) async {
  //   _database
  //       .child('users/$userId/vehicles')
  //       .child(vehicleKey)
  //       .update({'rating': rating, 'comment': commet});
  // }

  _onRatingSelected(double rating) {
    Navigator.pop(context, rating);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Rating and Review",
        onLeadingPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(apkDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.22,
                child: const Center(
                  child: Image(
                    image: AssetImage(servicizerLogo),
                  ),
                ),
              ),
              const SizedBox(height: apkDefaultSize - 10),
              Text(
                "How happy are you with the Service?",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: apkDefaultSize - 10),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Color.fromARGB(255, 102, 134, 163),
                      );
                    case 1:
                      return const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Color.fromARGB(255, 77, 114, 148),
                      );
                    case 2:
                      return const Icon(
                        Icons.sentiment_neutral,
                        color: Color.fromARGB(255, 51, 93, 133),
                      );
                    case 3:
                      return const Icon(
                        Icons.sentiment_satisfied,
                        color: Color.fromARGB(255, 26, 73, 117),
                      );
                    case 4:
                      return const Icon(
                        Icons.sentiment_very_satisfied,
                        color: Color.fromARGB(255, 0, 53, 102),
                      );
                    default:
                      return const Text("");
                  }
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    _userRating = rating;
                  });
                },
              ),
              const SizedBox(height: apkDefaultSize - 10),
              Text(
                "Your Rating: $_userRating", // Display selected rating
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: apkDefaultSize + 5),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: apkDefaultSize + 5),
              Text(
                "Leave a comment",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: apkDefaultSize - 10),
              Container(
                height: 100,
                child: TextField(
                  controller: commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Comment",
                    hintText: "",
                    prefixIcon: Icon(Icons.feedback_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50, // Increased height
                child: ElevatedButton(
                  onPressed: () {
                    // _rateVehicle(widget.linkKey, _userRating,
                    //     commentController.text.trim(), _currentUser!.uid);

                    // widget.rateLocationCallback(
                    //   widget.linkKey,
                    //   _userRating,
                    //   commentController.text.trim(),
                    // );

                    widget.addRatings(
                      _userRating,
                      commentController.text.trim(),
                      widget.linkKey,
                    );

                    _onRatingSelected(_userRating);

                    //Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                    textStyle: TextStyle(color: Colors.white), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: Text(
                    "Submit".toUpperCase(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: apkDefaultSize - 20),
            ],
          ),
        ),
      ),
    );
  }
}
