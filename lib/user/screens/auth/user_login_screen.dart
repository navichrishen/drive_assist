import 'package:drive_assist/servicizer/providers/servicizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:drive_assist/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import '../../../common widgets/common_methods.dart';
import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_text_field.dart';
import '../../../common widgets/dialog_loader.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import '../../providers/user.dart';
import '../navigation/bottom_navBar.dart';
import 'user_registration_screen.dart';
import '../../../servicizer/screens/servicizer_bottomNavBar.dart';
import 'dart:convert';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: apkUserLoginAppBarTitle,
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
                child: const Center(
                  child: Image(
                    image: AssetImage(apkLogo),
                  ),
                ),
              ),
              Text(apkUserLoginTitle,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: apkDefaultSize - 28),
              Text(apkUserLoginSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: apkDefaultSize - 10),
              CustomTextField(
                controller: emailTextEditingController,
                labelText: apkEmailTxt,
                hintText: apkEmailHintTxt,
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomTextField(
                controller: passwordTextEditingController,
                labelText: apkPasswordTxt,
                hintText: apkPasswordHintTxt,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.remove_red_eye,
                obscureText: true,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: const Text(apkForgotPasswordTxt)),
              ),
              const SizedBox(height: apkDefaultSize - 20),
              SizedBox(
                width: double.infinity,
                height: 50, // Increased height
                child: ElevatedButton(
                  onPressed: () {
                    networkAvailability();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const BottomNavBarScreen()),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 0, 29, 61), // Background color
                    textStyle:
                        const TextStyle(color: Colors.white), // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  child: Text(
                    apkLoginTxt.toUpperCase(),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: apkDefaultSize - 20),
              const Align(alignment: Alignment.center, child: Text(apkOrTxt)),
              const SizedBox(height: apkDefaultSize - 20),
              SizedBox(
                width: double.infinity,
                height: 50, // Increased height
                child: OutlinedButton.icon(
                  icon: const Image(image: AssetImage(googleLogo), width: 30.0),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  label: const Text(
                    apkSignUpGoogleTxt,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: apkDefaultSize - 20),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserRegistrationScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                        text: apkDontHvAcTxt,
                        style: Theme.of(context).textTheme.bodyText1,
                        children: const [
                          TextSpan(
                              text: apkSignUpTxt,
                              style: TextStyle(color: Colors.blue))
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Cntrollers
  CommonMethods commonlyUsedMethods = CommonMethods();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  networkAvailability() {
    // commonlyUsedMethods.checkConnectivity(context);
    userLoginValidation();
  }

  userLoginValidation() {
    if (!emailTextEditingController.text.contains("@")) {
      commonlyUsedMethods.displayTheSnackBar(
          "Please give a working email address", context);
    } else if (passwordTextEditingController.text.trim().length < 7) {
      commonlyUsedMethods.displayTheSnackBar(
          "Please enter a minimum of eight characters in your password",
          context);
    } else {
      userLogin();
    }
  }

  Future<void> userLogin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext contect) => LoadingDialogBox(messageText: "Login"),
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )
          .catchError((errorMsg) {
        Navigator.pop(context);
        commonlyUsedMethods.displayTheSnackBar(errorMsg.toString(), context);
      });

      //UserInstance().firstName = userCredential.user!.displayName;

      if (userCredential == null) {
        developer.log("UserCredential is NULL");
        return;
      }

      // Save the user's email to SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', userCredential.user!.email!);

      // Log the user's email
      developer.log("User Email: ${userCredential.user!.email}");

      if (!context.mounted) return;
      Navigator.pop(context);

      // Redirect user based on block status
      final DatabaseReference usersRef = FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(userCredential.user!.uid);

      usersRef.once().then((snapshot) {
        DataSnapshot dataSnapshot = snapshot.snapshot;
        if (dataSnapshot.value != null) {
          dynamic value = dataSnapshot.value;
          String jsonString = jsonEncode(value);
          Map<String, dynamic> decodedData = jsonDecode(jsonString);
          String role = decodedData['role'];
          String username = decodedData['fullName'];
          String email = decodedData['email'];
          String phoneNumber = decodedData['contactNumber'];

          UserInstance().firstName = username;
          UserInstance().email = email;
          UserInstance().phoneNumber = phoneNumber;
          //print(UserInstance().firstName);

          if (role == "Servicizer") {
            prefs.setString('user_name', username);
            prefs.setString('contact_number', phoneNumber);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => const ServiccizerBottomNavBar()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const BottomNavBarScreen()));
          }
        } else {
          FirebaseAuth.instance.signOut();
          commonlyUsedMethods.displayTheSnackBar(
              "You are not a registered user", context);
        }
      });
    } catch (error) {
      Navigator.pop(context);
      commonlyUsedMethods.displayTheSnackBar(error.toString(), context);
    }
  }

  String extractRole(Map<String, dynamic> data) {
    if (data.containsKey('role')) {
      return data['role'];
    } else {
      return 'none'; // or any default value you prefer
    }
  }
}
