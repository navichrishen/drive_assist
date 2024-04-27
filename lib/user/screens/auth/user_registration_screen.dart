import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:drive_assist/constants/sizes.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/common_methods.dart';
import '../../../common widgets/custom_dropDown.dart';
import '../../../common widgets/custom_text_field.dart';
import '../../../common widgets/dialog_loader.dart';
import '../../../constants/image_strings.dart';
import '../../../constants/text_strings.dart';
import 'user_login_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: apkUserRegiAppBarTitle,
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
              Text(apkUserRegiTitle,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: apkDefaultSize - 28),
              Text(apkUserRegiSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: apkDefaultSize - 10),
              CustomTextField(
                controller: fullNameTextEditingController,
                labelText: apkFullNameTxt,
                hintText: apkFullNameHintTxt,
                prefixIcon: Icons.person_outline_outlined,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomTextField(
                controller: emailTextEditingController,
                labelText: apkEmailTxt,
                hintText: apkEmailHintTxt,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomTextField(
                controller: contactNumTextEditingController,
                labelText: apkContactNumTxt,
                hintText: apkContactNumHintTxt,
                prefixIcon: Icons.phone_enabled_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomDropdown(
                labelText: "User Role",
                hintText: "select your role",
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Vehicle Owner',
                    child: Text('Vehicle Owner'),
                  ),
                  DropdownMenuItem(
                    value: 'Servicizer',
                    child: Text('Servicizer'),
                  ),
                ],
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomTextField(
                controller: passwordTextEditingController,
                labelText: apkPasswordTxt,
                hintText: apkPasswordHintTxt,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.remove_red_eye,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomTextField(
                controller: confPasswordTextEditingController,
                labelText: apkConfPasswordTxt,
                hintText: apkConfPasswordHintTxt,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.remove_red_eye,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              SizedBox(
                width: double.infinity,
                height: 50, // Increased height
                child: ElevatedButton(
                  onPressed: () {
                    networkAvailability();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 29, 61),
                    textStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    apkSignUpTxt.toUpperCase(),
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
                    backgroundColor:
                        const Color.fromARGB(255, 0, 29, 61), // Border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Border radius
                    ),
                  ),
                  label: const Text(
                    apkSignUpGoogleTxt,
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16, // Adjust font size if necessary
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
                          builder: (context) => const UserLoginScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                        text: apkAlreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyText1,
                        children: const [
                          TextSpan(
                              text: apkLoginTxt,
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
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController contactNumTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confPasswordTextEditingController =
      TextEditingController();

  networkAvailability() {
    // commonlyUsedMethods.checkConnectivity(context);
    userValidation();
  }

  userValidation() {
    if (fullNameTextEditingController.text.trim().length < 5) {
      commonlyUsedMethods.displayTheSnackBar(
          "There must be five or more characters in your user name", context);
    } else if (!emailTextEditingController.text.contains("@")) {
      commonlyUsedMethods.displayTheSnackBar(
          "Please give a working email address", context);
    } else if (contactNumTextEditingController.text.trim().length < 9) {
      commonlyUsedMethods.displayTheSnackBar(
          "Please give a working phone number", context);
    } else if (passwordTextEditingController.text.trim().length < 7) {
      commonlyUsedMethods.displayTheSnackBar(
          "Please enter a minimum of eight characters in your password",
          context);
    } else if (passwordTextEditingController.text.trim() !=
        confPasswordTextEditingController.text.trim()) {
      commonlyUsedMethods.displayTheSnackBar(
          "Your password and the conform password do not match", context);
    } else {
      newUserRegistration();
    }
  }

  newUserRegistration() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext contect) =>
          LoadingDialogBox(messageText: "Registering you."),
    );

    // creating a new user in firebase authentication
    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((errorMsg) {
      Navigator.pop(context);
      commonlyUsedMethods.displayTheSnackBar(errorMsg.toString(), context);
    }))
        .user;

    if (!context.mounted) return;
    Navigator.pop(context);

    // database reference
    DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);

    // map data in database
    Map userDataMap = {
      "fullName": fullNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "contactNumber": contactNumTextEditingController.text.trim(),
      "role": selectedValue,
      "userId": userFirebase.uid,
      "blockStatus": "no",
    };
    usersRef.set(userDataMap);

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const UserLoginScreen()));
  }
}
