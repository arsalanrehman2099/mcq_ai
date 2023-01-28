import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/controllers/user_controller.dart';
import 'package:mcq_ai/views/splash_screen.dart';

late List<CameraDescription> _cameras;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  _cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz.AI',
      theme: ThemeData(primaryColor: Colors.red),
      home:  SplashScreen(),
    );
  }
}
