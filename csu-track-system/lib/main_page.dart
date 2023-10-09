import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/navbar.dart';
import 'controllers/auth_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/mainpage";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const NavBar();
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}
