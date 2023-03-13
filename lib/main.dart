import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/controllers/quiz_controller.dart';
import 'package:mcq_ai/controllers/user_controller.dart';
import 'package:mcq_ai/views/auth/splash_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserController _userController = Get.put(UserController());
  final QuizController _quizController = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz.AI',
      theme: ThemeData(primaryColor: Colors.red),
      home:  SplashScreen(),
    );
  }
}
