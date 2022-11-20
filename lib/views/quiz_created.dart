import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard_screen.dart';
import 'package:mcq_ai/widgets/my_elevated_button.dart';

class QuizCreatedScreen extends StatelessWidget {
  const QuizCreatedScreen({Key? key}) : super(key: key);

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
              onClick: () {},
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
