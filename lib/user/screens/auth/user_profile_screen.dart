// import 'package:flutter/material.dart';

// import '../../../common widgets/custom_appBar.dart';
// import '../../../common widgets/custom_text_field.dart';
// import '../../../constants/sizes.dart';
// import '../../../constants/text_strings.dart';

// class UserProfileScreen extends StatefulWidget {
//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }

// class _UserProfileScreenState extends State<UserProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: CustomAppBar(
//         title: apkUserProfileAppBarTitle,
//         onLeadingPressed: () {},
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 40),
//                       child: Column(
//                         children: [
//                           //codings for profile avatar
//                           Center(
//                             child: Stack(
//                               alignment: Alignment
//                                   .bottomRight, // Adjust alignment as needed
//                               children: [
//                                 CircleAvatar(
//                                   radius: 70,
//                                   backgroundImage: AssetImage(
//                                       'assets/images/profileAvatar.png'),
//                                 ),
//                                 Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: IconButton(
//                                     icon: Icon(
//                                       Icons.edit,
//                                       color: Colors.blue,
//                                     ),
//                                     onPressed: () {
//                                       // Handle edit button press
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: apkDefaultSize - 20),
//                           CustomTextField(
//                             labelText: apkFullNameTxt,
//                             hintText: apkFullNameHintTxt,
//                             prefixIcon: Icons.person_outline_outlined,
//                           ),
//                           const SizedBox(height: apkDefaultSize - 20),
//                           CustomTextField(
//                             labelText: apkEmailTxt,
//                             hintText: apkEmailHintTxt,
//                             prefixIcon: Icons.email_outlined,
//                           ),
//                           const SizedBox(height: apkDefaultSize - 20),
//                           CustomTextField(
//                             labelText: apkContactNumTxt,
//                             hintText: apkContactNumHintTxt,
//                             prefixIcon: Icons.phone_enabled_outlined,
//                           ),
//                           const SizedBox(height: apkDefaultSize - 20),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 40),
//                       child: Container(
//                         padding: EdgeInsets.only(top: 3, left: 3),
//                         child: MaterialButton(
//                           minWidth: double.infinity,
//                           height: 60,
//                           onPressed: () {},
//                           color: const Color.fromARGB(255, 0, 29, 61238),
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Text(
//                             apkUpdateTxt,
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_text_field.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../../providers/user.dart';
import '../navigation/bottom_navBar.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController contactNumController = TextEditingController();
  DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _currentUser;

  void _getCurrentUser() {
    _currentUser = _auth.currentUser;
  }

  // Method to update user information in Firebase

  // Access the user instance

  // try {
  //   String? userId = UserInstance().userId;

  //   // await _database.child('users/$userId').update({
  //   //   'firstName': UserInstance().firstName,
  //   //   'email': UserInstance().email,
  //   //   // Assuming you have 'phoneNumber' in your UserInstance class
  //   //   'phoneNumber': UserInstance().phoneNumber,
  //   // });
  //   await _database.child('users/$userId').update(vehicleData).then((value) =>
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Successfully updated a vehicle'))));
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text('User information updated successfully'),
  //   ));
  // } catch (error) {
  //   // Handle errors
  //   print('Error updating user information: $error');
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text('Failed to update user information'),
  //   ));
  // }

  Future<void> updateInformation(String userId) async {
    UserInstance userInstance = UserInstance();

    // Update the user information
    userInstance.firstName = fullNameController.text;
    userInstance.email = emailController.text;
    userInstance.phoneNumber = contactNumController.text;
    Map<String, dynamic> userData = {
      'fullName': fullNameController.text.trim(),
      'email': emailController.text.trim(),
      'contactNumber': contactNumController.text.trim()
    };

    await _database
        .child('users/$userId')
        .update(userData)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully updated a user data'))))
        .then((value) => Navigator.push(context,
            MaterialPageRoute(builder: (context) => BottomNavBarScreen())));
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    // Set initial values to the text controllers
    fullNameController.text = UserInstance().firstName ?? '';
    emailController.text = UserInstance().email ?? '';
    // Assuming you have a property in UserInstance for contact number
    contactNumController.text = UserInstance().phoneNumber ?? '';
  }

  _onDetailsSelected(String firstName, String email) {
    Map<String, dynamic> displayData = {
      'fullName': firstName,
      'email': email,
    };
    Navigator.pop(context, displayData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: apkUserProfileAppBarTitle,
        onLeadingPressed: () {},
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          //codings for profile avatar
                          Center(
                            child: Stack(
                              alignment: Alignment
                                  .bottomRight, // Adjust alignment as needed
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: AssetImage(
                                      'assets/images/profileAvatar.png'),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      // Handle edit button press
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: apkDefaultSize - 20),
                          CustomTextField(
                            controller: fullNameController,
                            labelText: apkFullNameTxt,
                            hintText: apkFullNameHintTxt,
                            prefixIcon: Icons.person_outline_outlined,
                          ),
                          const SizedBox(height: apkDefaultSize - 20),
                          CustomTextField(
                            controller: emailController,
                            labelText: apkEmailTxt,
                            hintText: apkEmailHintTxt,
                            prefixIcon: Icons.email_outlined,
                          ),
                          const SizedBox(height: apkDefaultSize - 20),
                          CustomTextField(
                            controller: contactNumController,
                            labelText: apkContactNumTxt,
                            hintText: apkContactNumHintTxt,
                            prefixIcon: Icons.phone_enabled_outlined,
                          ),
                          const SizedBox(height: apkDefaultSize - 20),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            updateInformation(_currentUser!.uid);
                            // _onDetailsSelected(
                            //     fullNameController.text, emailController.text);
                          },
                          color: const Color.fromARGB(255, 0, 29, 61238),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            apkUpdateTxt,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
