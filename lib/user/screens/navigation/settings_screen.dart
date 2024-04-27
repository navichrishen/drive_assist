import 'package:drive_assist/user/providers/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common widgets/custom_appBar.dart';
import '../../../common widgets/custom_settings_listTile.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import '../auth/user_login_screen.dart';
import '../auth/user_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? firstName;
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName = UserInstance().firstName;
    email = UserInstance().email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: apkSettingsAppBarTitle,
        onLeadingPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfileScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 51, 93, 133),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35.0, // Increased radius to 75
                        backgroundImage:
                            AssetImage('assets/images/userAvatar.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              firstName!,
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              email!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: apkDefaultSize + 15),
              CustomSettingsListTile(
                leadingIcon: Icons.language_outlined,
                trailingIcon: Icons.navigate_next_rounded,
                title: apkSettingsTileTitleOne,
                onTap: () {},
                tileColor: Colors.white,
                textColor: const Color.fromARGB(255, 19, 53, 123),
                iconColor: const Color.fromARGB(255, 19, 53, 123),
                borderRadius: 10.0,
              ),
              const SizedBox(height: apkDefaultSize - 20),
              CustomSettingsListTile(
                leadingIcon: Icons.logout_rounded,
                trailingIcon: Icons.navigate_next_rounded,
                title: apkSettingsTileTitleTwo,
                onTap: () async {
                  try {
                    await _auth.signOut().then(
                          (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserLoginScreen()),
                          ),
                        );
                  } catch (e) {
                    print(e);
                  }
                },
                tileColor: Colors.white,
                textColor: const Color.fromARGB(255, 19, 53, 123),
                iconColor: const Color.fromARGB(255, 19, 53, 123),
                borderRadius: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
