import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  String? name;
  String? email;
  String? password;
  Timestamp? createdAt;

  User({this.id, this.password,this.name, this.email, this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

  User fromJson(Map user) {
    return User(
      id: user['id'],
      name: user['name'],
      email: user['email'],
      createdAt: user['createdAt'],
    );
  }
}