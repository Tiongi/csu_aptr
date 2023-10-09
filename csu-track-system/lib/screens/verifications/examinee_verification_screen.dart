import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/main_page.dart';
import 'package:quizzle/screens/exam/examSubjects_screen.dart';

class ExamineeVerificationScreen extends StatefulWidget {
  static const String routeName = "/examineeverificationscreen";

  const ExamineeVerificationScreen({Key? key}) : super(key: key);

  @override
  _ExamineeVerificationScreenState createState() =>
      _ExamineeVerificationScreenState();
}

class _ExamineeVerificationScreenState
    extends State<ExamineeVerificationScreen> {
  String _verificationCode = '';
  bool _isCodeValid =
      true; // set to true initially to avoid showing warning message on the first run

  Future<bool> _checkVerificationCode(String code) async {
    // Connect to Cloud Firestore and retrieve the verification codes collection
    final codesCollection =
        FirebaseFirestore.instance.collection('verification_codes');

    // Query the collection for the entered verification code
    final querySnapshot =
        await codesCollection.where('code', isEqualTo: code).get();

    // Check if the entered verification code matches any code in the collection
    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the main page when the back button is pressed
            Navigator.of(context).pushNamed(MainPage.routeName);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Wait for your proctor to provide the verification code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          fontSize: MediaQuery.of(context).size.height * 0.030,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.020,
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _verificationCode = value;
                            _isCodeValid =
                                true; // set to true to hide warning message
                          });
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Enter verification code',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.010,
                      ),
                      if (!_isCodeValid && _verificationCode.isNotEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Invalid verification code, please try again',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ElevatedButton(
                        onPressed: _verificationCode.isNotEmpty
                            ? () async {
                                // Check if the entered verification code is valid
                                final isCodeValid =
                                    await _checkVerificationCode(
                                        _verificationCode);

                                setState(() {
                                  _isCodeValid = isCodeValid;
                                });
                                // Navigate to the next screen if the verification code is valid
                                if (_isCodeValid) {
                                  Navigator.pushReplacementNamed(
                                      context, ExamSubjectsScreen.routeName);
                                }
                              }
                            : null,
                        child: const Text('Verify Code'),
                      ),
                    ],
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
