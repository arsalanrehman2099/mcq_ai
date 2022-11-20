import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/views/splash_screen.dart';

late List<CameraDescription> _cameras;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz.AI',
      theme: ThemeData(primaryColor: Colors.red),
      home:  SplashScreen(),
    );
  }
}
