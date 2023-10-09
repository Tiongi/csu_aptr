import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/auth_controller.dart';

bool isDarkMode = false;
const double paddingDefault = 15.0;

const textMainColor = Color(0x00000000);
const Color onSurfaceTextColor = Color.fromARGB(0, 119, 26, 26);
const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFFf85187);
const Color notAnsweredColor = Color(0xFF2a3c65);

const darkRed = Color(0xFFB60808);
const yellow = Color(0xFFFFD700);
const lightYellow = Color.fromARGB(255, 206, 242, 114);
const violet = Color(0xFF061043);
final primarygray = Color.fromARGB(255, 41, 40, 40);

final backgroundColorDark = primarygray;
final backgroundColorLight = Color(0xFF00FFCB);

const primGradient = LinearGradient(
  colors: [darkRed, yellow],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const vioGradient = LinearGradient(
  colors: [violet, lightVio],
  begin: Alignment.bottomRight,
  end: Alignment.topLeft,
);

const mainGradientDark = LinearGradient(
  colors: [yellow, darkRed],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const lightVioGradient = LinearGradient(
  colors: [lightVio, violet],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
//Red Shades

const lightRed = Color(0xFFDE3B26);
const lightRed2 = Color(0xFFFF8362);

//violet shades
const lightVio = Color(0xFF003771);
const lightGray = Color(0xFF508072);
const lightGray2 = Color(0xFF00C898);

//3 shades vio and darkred
const lightBlue = Color(0xFF5F246F);

Future<String> _getUserGreeting() async {
  final AuthController _auth = Get.find();
  final user = _auth.getUser();
  String _label = 'Hello mate';

  if (user != null) {
    try {
      final email = user.email;
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email) // Assuming the document ID is the user's email
          .get();

      if (userSnapshot.exists) {
        final firstName = userSnapshot['first name'];
        final lastName = userSnapshot['last name'];
        _label = ' Hi $firstName $lastName';
      }
    } catch (e) {
      // Handle any errors that might occur during the Firestore query
      print('Error fetching user data: $e');
    }
  }

  return _label;
}
