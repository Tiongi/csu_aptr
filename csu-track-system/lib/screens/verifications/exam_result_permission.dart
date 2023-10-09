import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/screens/recommender/track_recommender.dart';

import '../../constants/constant.dart';
import '../../main_page.dart';

class ResultPermissionScreen extends StatefulWidget {
  static const String routeName = "/resultpermitscreen";

  const ResultPermissionScreen({Key? key}) : super(key: key);

  @override
  _ResultPermissionScreenState createState() => _ResultPermissionScreenState();
}

class _ResultPermissionScreenState extends State<ResultPermissionScreen> {
  String _verificationCode = '';
  bool _isCodeValid =
      true; // set to true initially to avoid showing warning message on the first run

  Future<bool> _checkVerificationCode(String code) async {
    // Connect to Cloud Firestore and retrieve the verification codes collection
    final codesCollection =
        FirebaseFirestore.instance.collection('result_permission_codes');

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
                        'Permission code is required',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                          fontSize: MediaQuery.of(context).size.height * 0.035,
                        ),
                      ),
                      Text(
                        'Wait for your proctor to give the permission code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.bebasNeue(
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            color: darkRed),
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
                          hintText: 'Enter permission code',
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
                            'Invalid Permission code, please try again',
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
                                      context, TrackRecommender.routeName);
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
