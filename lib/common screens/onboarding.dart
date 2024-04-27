import 'package:drive_assist/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../user/screens/auth/user_login_screen.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final pageController = PageController();
  final selectedIndex = ValueNotifier(0);
  final illustrations = [
    "assets/annimations/ani.json",
    "assets/annimations/ani02.json",
    "assets/annimations/ani03.json",
  ];
  final titles = [
    "Welcome to MyApp!",
    "Discover Exciting Features",
    "Get Started Now!",
  ];
  final descs = [
    "Explore the amazing features of our app and enhance your experience.",
    "Explore unique features designed to make your tasks easier and enjoyable.",
    "Join us on this exciting journey. Sign up now to unlock the full potential of MyApp.",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 130,
              color: AppColor.apkPrimaryColor,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: illustrations.length,
              itemBuilder: (context, index) {
                return _PageLayout(
                  illustrations: illustrations[index],
                  titles: titles[index],
                  descs: descs[index],
                );
              },
              onPageChanged: (value) {
                selectedIndex.value = value;
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (context, index, child) {
              return Padding(
                padding: EdgeInsets.only(top: 16, bottom: 32),
                child: Wrap(
                  spacing: 8,
                  children:
                      List.generate(illustrations.length, (indexIndicator) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 8,
                      width: indexIndicator == index ? 24 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: indexIndicator == index
                            ? AppColor.apkPrimaryColor
                            : AppColor.apkPrimaryColor.withOpacity(0.5),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: ValueListenableBuilder(
              valueListenable: selectedIndex,
              builder: (context, index, child) {
                if (index == illustrations.length - 1) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserLoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: AppColor.apkPrimaryColor,
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        pageController.jumpToPage(illustrations.length - 1);
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColor.apkPrimaryColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final nextPage = selectedIndex.value + 1;
                        pageController.animateToPage(
                          nextPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: AppColor.apkPrimaryColor,
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class _PageLayout extends StatelessWidget {
  const _PageLayout({
    required this.illustrations,
    required this.titles,
    required this.descs,
  });

  final String illustrations;
  final String titles;
  final String descs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Lottie.asset(
              illustrations,
            ),
          ),
          Text(
            titles,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            descs,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
