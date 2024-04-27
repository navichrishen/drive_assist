import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

import 'servicizer_dashboard.dart';
import 'servicizer_settings.dart';

class ServiccizerBottomNavBar extends StatefulWidget {
  const ServiccizerBottomNavBar({Key? key}) : super(key: key);

  @override
  State<ServiccizerBottomNavBar> createState() =>
      _ServiccizerBottomNavBarState();
}

class _ServiccizerBottomNavBarState extends State<ServiccizerBottomNavBar> {
  int _currentPage = 0;
  final _pageController = PageController();

  final List<Widget> _pages = [
    ServicizerDashboardScreen(),
    ServicizerSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: BottomBar(
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentPage = index);
          },
          items: const <BottomBarItem>[
            BottomBarItem(
              icon: Icon(Icons.home_filled),
              title: Text("Home"),
              activeColor: Color.fromARGB(255, 0, 29, 61),
            ),
            BottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              activeColor: Color.fromARGB(255, 0, 29, 61),
            ),
          ],
        ),
      ),
    );
  }
}
