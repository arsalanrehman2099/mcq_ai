import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/raw_data.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard_screen.dart';
import 'package:mcq_ai/views/edit_quiz.dart';
import 'package:mcq_ai/views/new_quiz.dart';
import 'package:mcq_ai/widgets/my_elevated_button.dart';

import 'camera_page.dart';

class QuizActionScreen extends StatelessWidget {
  const QuizActionScreen({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Quiz.AI'),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                RawData.DATA[index]['title'].toString(),
                style: ConstantManager.ktextStyle.copyWith(
                    fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical!),
              Text(
                RawData.DATA[index]['subtitle'].toString(),
                style: ConstantManager.ktextStyle
                    .copyWith(fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical!),
              Text(
                '(${RawData.DATA[index]['date']})',
                style: ConstantManager.ktextStyle
                    .copyWith(fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical! * 3.5),
              _button(
                text: 'Marking/Grading',
                onClick: () async{
                  await availableCameras().then((value) => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
                },
              ),
              _button(
                text: 'Generate PDF',
                onClick: () {},
              ),
              _button(
                text: 'Edit Quiz',
                onClick: () {
                  Get.to(() => EditQuizScreen(index: index));
                },
              ),
              _button(
                text: 'Delete Quiz',
                onClick: () {
                  MyConfirmationDialog().showConfirmationDialog(context,
                      message: "Are you sure you want to delete this quiz?",
                      onConfirm: () {
                    Get.offAll(() => DashboardScreen());
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button({text, onClick}) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal! * 60,
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: ConstantManager.PRIMARY_COLOR,
        ),
        child: Text(
          text!.toUpperCase(),
          style: ConstantManager.ktextStyle.copyWith(letterSpacing: 1.2),
        ),
      ),
    );
  }
}
