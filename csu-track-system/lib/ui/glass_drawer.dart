import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassDrawer extends StatelessWidget {
  final Widget child;

  const FrostedGlassDrawer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 300,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 255, 2, 2),
                Color.fromARGB(255, 168, 2, 2),
                Color.fromARGB(255, 102, 1, 1),
                Color.fromARGB(255, 60, 0, 0),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 2, color: Colors.white)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 5, sigmaY: 5), // Adjust the sigma values as needed
          child: Container(
            color: Colors.white.withOpacity(0.1), // Adjust opacity as needed
            child: child,
          ),
        ),
      ),
    );
  }
}
