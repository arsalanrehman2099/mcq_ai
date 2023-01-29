import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/models/quiz.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/widgets/my_elevated_button.dart';

import 'dashboard_screen.dart';

class QuizCreatedScreen extends StatelessWidget {
  final Quiz quiz;

  const QuizCreatedScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      appBar: ConstantManager.appBar('Quiz Created'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Quiz has been\ncreated.'.toUpperCase(),
              textAlign: TextAlign.center,
              style: ConstantManager.ktextStyle.copyWith(
                color: Colors.black,
                letterSpacing: 1.5,
                fontSize: SizeConfig.safeBlockHorizontal! * 6.0,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 4.0),
            MyElevatedButton(
              text: 'Generate PDF',
              onClick: () {
                print(quiz);
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical!),
            MyElevatedButton(
              text: 'Back to home',
              onClick: () => Get.offAll(() => DashboardScreen(),),
            ),
          ],
        ),
      ),
    );
  }
}
