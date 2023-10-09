import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzle/constants/constant.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:quizzle/firebase/references.dart';
import 'package:quizzle/screens/screens.dart' show ExamScreen;
import 'package:quizzle/utils/logger.dart';

import '../../models/exam_paper_model.dart' show ExamPaperModel;

class ExamPaperController extends GetxController {
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  final allPapers = <ExamPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  Future<void> getAllPapers() async {
    List<String> imgName = ["english", "filipino", "mathematics", "science"];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await examPaperFR.get();
      final paperList =
          data.docs.map((paper) => ExamPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var img in imgName) {
        // Load image from assets folder
        final imgUrl =
            'assets/images/$img.png'; // Update the image path according to your assets folder structure
        allPaperImages.add(imgUrl);
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToQuestions(
      {required BuildContext context, // Add this parameter
      required ExamPaperModel paper,
      bool isTryAgain = false}) {
    AuthController _authController = Get.find();
    String? userEmail =
        user.email; // Replace with your method to get the user's email

    // Replace 'ppr001' with the specific exam name you want to check
    String examNameToCheck = paper.id;

    // Reference to the 'exams' collection for the user
    CollectionReference examsCollection = FirebaseFirestore.instance
        .collection('submitted_answers/$userEmail/exams');

    // Check if the specific exam document exists
    examsCollection.doc(examNameToCheck).get().then((docSnapshot) {
      if (docSnapshot.exists) {
        // The exam document exists, show an alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Exam Already Submitted',
                style: GoogleFonts.bebasNeue(color: darkRed),
              ),
              content: Text('You already submitted this exam.',
                  style: GoogleFonts.bebasNeue()),
              actions: [
                Container(
                  decoration: BoxDecoration(
                      gradient: primGradient,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Ok',
                      style: GoogleFonts.bebasNeue(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the alert dialog
                    },
                  ),
                ),
              ],
            );
          },
        );
      } else {
        // The exam document does not exist, navigate to QuizeScreen
        Get.offNamed(ExamScreen.routeName,
            arguments: paper, preventDuplicates: false);
      }
    });
  }
}

class FirestoreService {
  Future<bool> checkUserEmailExistsInSubmittedAnswers(String userEmail) async {
    CollectionReference submittedAnswersCollection =
        FirebaseFirestore.instance.collection('submitted_answers');

    QuerySnapshot snapshot = await submittedAnswersCollection.get();

    for (QueryDocumentSnapshot document in snapshot.docs) {
      String documentId = document.id;
      if (documentId.contains(userEmail)) {
        return true;
      }
    }

    return false;
  }
}

// Usage:
FirestoreService firestoreService = FirestoreService();
