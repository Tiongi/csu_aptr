import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fi = FirebaseFirestore.instance;

//FR - firestore reference

final user = FirebaseAuth.instance.currentUser!;
final userFR = fi.collection('users');
final submittedAnswerFR = fi.collection('submitted_answers');
final examPaperFR = fi.collection('quizpapers');
final leaderBoardFR = fi.collection('leaderboard');

CollectionReference<Map<String, dynamic>> getSubmittedAnswers(
        {required String userId}) =>
    submittedAnswerFR.doc(userId).collection('exams');

DocumentReference questionsFR(
        {required String paperId, required String questionsId}) =>
    examPaperFR.doc(paperId).collection('questions').doc(questionsId);

//Reference get firebaseStorage => FirebaseStorage.instanceFor(bucket: 'gs://fire-base-chat-cc3e9.appspot.com').ref();
Reference get firebaseStorage => FirebaseStorage.instance.ref();
