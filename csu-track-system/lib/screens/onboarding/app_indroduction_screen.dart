import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/constants/constant.dart';
import 'package:quizzle/main_page.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  // Define a unique route name for this screen.
  static const String routeName = '/introduction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          // Apply horizontal padding based on screen width using Get.width.
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.070),
          child: EasySeparatedColumn(
            // Create a column with separators between its children.
            separatorBuilder: (context, index) => const SizedBox(
              height: 50,
            ),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display an icon with custom size and color.
              const Icon(
                Icons.question_mark_rounded,
                size: 150,
                color: yellow,
              ),
              Text(
                // Display a message about the app's exclusivity.
                'This Track Examination App is exclusively for students and staff of the College of Information and Computer Sciences at Cagayan State University.',
                textAlign: TextAlign.center,
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () => Get.offAndToNamed(MainPage.routeName),
                style: ButtonStyle(
                  // Customize the button's background color.
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'I Understand',
                    style: GoogleFonts.bebasNeue(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
