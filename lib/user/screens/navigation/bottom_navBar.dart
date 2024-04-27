import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

import '../../../constants/colors.dart';
import '../vehicles/venicles_screen.dart';
import 'dashboard.dart';
import 'settings_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  final List<Widget> _pages = [
    UserDashboard(),
    MyVehiclesScreen(),
    SettingsScreen(),
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
      bottomNavigationBar: BottomBar(
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
            icon: Icon(Icons.directions_car_sharp),
            title: Text("My Vehicles"),
            activeColor: Color.fromARGB(255, 0, 29, 61),
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
            activeColor: Color.fromARGB(255, 0, 29, 61),
          ),
        ],
      ),
    );
  }
}
