import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constant.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isKeyboardVisible = false;
  bool _hidePassword = true;
  bool _isLoading = false;
  bool _showError = false;

  // Function to sign in using Firebase authentication.
  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Sign-in was successful.
    } catch (e) {
      // Sign-in failed.
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkRed,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 4),
                    height: 300,
                    child: const Image(
                      image: AssetImage('assets/images/TrackExamLogo.png'),
                    ),
                  ),
                  Text("Welcome",
                      style: GoogleFonts.pacifico(fontSize: 50, color: yellow)),
                  Text('to CSU-A Track Examination App',
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintText: 'Email',
                            hintStyle:
                                GoogleFonts.bebasNeue(color: Colors.grey[600]),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: TextField(
                          obscureText: _hidePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintText: 'Password',
                            hintStyle:
                                GoogleFonts.bebasNeue(color: Colors.grey[600]),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _hidePassword = !_hidePassword;
                                });
                              },
                              child: Icon(
                                _hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                      top: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                      // Adding bottom padding based on the height of the keyboard.
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                          _showError = false;
                        });

                        bool signInResult = await signIn();

                        setState(() {
                          _isLoading = false;
                          _showError = !signInResult;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: yellow,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : _showError
                                  ? Text(
                                      'Error logging in',
                                      style: GoogleFonts.bebasNeue(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    )
                                  : Text(
                                      'Sign in',
                                      style: GoogleFonts.pacifico(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not an examinee? ',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 15, color: Colors.white)),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: Text(
                          'Register now',
                          style: GoogleFonts.pacifico(
                              fontSize: 15,
                              color: yellow,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                        '2023 Cagayan State University Aparri Campus Maintained by CICS Management',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
