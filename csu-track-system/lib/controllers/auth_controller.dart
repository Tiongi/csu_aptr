import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/login_screen.dart';
import '../screens/onboarding/app_indroduction_screen.dart';
import '../screens/registration_screen.dart';


//THIS IS THE CODE FOR THE AUTHENTICATION LOGIC FOR USER STATE AND SOME NAVIGATION 

late FirebaseAuth _auth;

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 3)); // waiting in splash
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  void navigateToMainPage() {
    Get.offAllNamed("/mainpage");
  }

  bool isUserAuthorized() {
    return _auth.currentUser != null;
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  void navigateToIntroduction() {
    Get.offAllNamed(AppIntroductionScreen.routeName);
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: toggleScreen);
    } else {
      return RegisterPage(showLoginPage: toggleScreen);
    }
  }
}
