import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/firebase/references.dart';
import 'package:quizzle/services/notification/notification_service.dart';


extension ExamResult on ExamController {
  int get correctQuestionCount => allQuestions
      .where((question) => question.selectedAnswer == question.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (examPaperModel.timeSeconds - remainSeconds) /
        examPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveQuizResults() async {
    var batch = fi.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(
        submittedAnswerFR
            .doc(_user.email)
            .collection('exams')
            .doc(examPaperModel.id),
        {
          "points": double.parse(points),
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": examPaperModel.id,
          "time": examPaperModel.timeSeconds - remainSeconds
        });
    batch.set(
        leaderBoardFR
            .doc(examPaperModel.id)
            .collection('scores')
            .doc(_user.email),
        {
          "points": double.parse(points),
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": examPaperModel.id,
          "user_id": _user.email,
          "time": examPaperModel.timeSeconds - remainSeconds
        });
    await batch.commit();
    Get.find<NotificationService>().showQuizCompletedNotification(
        id: 1,
        title: examPaperModel.title,
        body:
            'You have just got $points points for ${examPaperModel.title} -  Tap here to view leaderboard',
        imageUrl: examPaperModel.imageUrl,
        payload: json.encode(examPaperModel.toJson()));
    navigatetoExaminationScreen();
  }
}
