import 'dart:async';

import 'package:drive_assist/common%20screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/image_strings.dart';
import '../user/screens/auth/user_login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => GetStartedScreen())));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.28,
            child: Center(
              child: Image(
                image: AssetImage(apkLogo),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Lottie.asset(
          //     'assets/animations/splashAnimation.json',
          //     height: 150,
          //     width: 150,
          //   ),
          // )
          Lottie.asset('assets/annimations/splashAnimation.json',
              height: 180, width: 180),
        ],
      ),
    );
  }
}
