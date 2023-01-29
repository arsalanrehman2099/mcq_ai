import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String? id;
  String? userId;
  String? title;
  String? subtitle;
  String? date;
  Map? questions;
  Timestamp? createdAt;

  Quiz({
    this.id,
    this.userId,
    this.title,
    this.subtitle,
    this.date,
    this.questions,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId':userId,
      'title': title,
      'subtitle': subtitle,
      'date':date,
      'questions':questions,
      'createdAt': createdAt,
    };
  }

  Quiz fromJson(Map quiz) {
    return Quiz(
      id: quiz['id'],
      userId:quiz['userId'],
      title: quiz['title'],
      subtitle: quiz['subtitle'],
      date: quiz['date'],
      questions: quiz['questions'],
      createdAt: quiz['createdAt'],
    );
  }
}
