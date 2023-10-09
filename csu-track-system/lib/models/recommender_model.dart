import 'package:cloud_firestore/cloud_firestore.dart';

class RecommenderData {
  final String? correctCount;
  final String? userId;
  final int? time;
  final String? paperId;
  final double? points;
  late UserData user;

  RecommenderData({
    this.correctCount,
    this.userId,
    this.time,
    this.paperId,
    this.points,
  });

  RecommenderData.fromJson(Map<String, dynamic> json)
    : correctCount = json['correct_count'] as String?,
      userId = json['email'] as String?,
      time = json['time'] as int?,
      paperId = json['paper_id'] as String?,
      points = json['points'] as double?;

  RecommenderData.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot)
    : correctCount = snapshot['correct_count'] as String?,
      userId = snapshot['email'] as String?,
      time = snapshot['time'] as int,
      paperId = snapshot['paper_id'] as String?,
      points = snapshot['points'] as double?;    

  Map<String, dynamic> toJson() => {
    'correct_count' : correctCount,
    'user_id' : userId,
    'time' : time,
    'paper_id' : paperId,
    'points' : points
  };
}

class UserData{
  final String name;

  UserData({required this.name});

  UserData.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot, ) : name = snapshot['first name'] as String;
}