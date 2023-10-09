import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../screens/verifications/exam_result_permission.dart';
import '../screens/verifications/examinee_verification_screen.dart';
import '../screens/home/home_screen.dart';

//THIS CODE IS THE BOTTOM NAVIGATION BAR

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/navbar";

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  var pagesAll = [
    const HomePage(),
    const ExamineeVerificationScreen(),
    const ResultPermissionScreen()
  ];
  var page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  void _pages(index) {
    setState(() {
      page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: violet,
        buttonBackgroundColor: darkRed,
        height: 70,
        items: <Widget>[
          Icon(
            (page == 0) ? Icons.home : Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            (page == 1)
                ? Icons.app_registration_rounded
                : Icons.app_registration_rounded,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            (page == 2) ? Icons.send_rounded : Icons.send_rounded,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: _pages,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        color: violet,
      ),
      body: pagesAll[page],
    );
  }
}
