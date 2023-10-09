import 'package:flutter/material.dart';

import '../../constants/constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: primGradient),
        child: Image.asset(
          "assets/images/TrackExamLogo.png",
          height: 300,
          width: 300,
        ),
      ),
    );
  }
}
