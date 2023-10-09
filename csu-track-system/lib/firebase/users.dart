import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;
  final String? email;
  final List<String> takenExams;

  User({
    required this.uid,
    this.email,
    this.takenExams = const [],
  });

  factory User.fromFirebaseUser(User user) {
    return User(
      uid: user.uid,
      email: user.email,
      takenExams: [],
    );
  }
}
