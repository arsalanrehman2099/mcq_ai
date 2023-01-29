import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mcq_ai/controllers/quiz_controller.dart';
import 'package:mcq_ai/models/quiz.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/raw_data.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard/edit_quiz.dart';
import 'package:mcq_ai/views/dashboard/view_quiz.dart';

import '../../services/pdf_api.dart';
import '../../widgets/overlay_loader.dart';
import 'camera_page.dart';
import 'dashboard_screen.dart';

class QuizActionScreen extends StatelessWidget {
  QuizActionScreen({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  final QuizController _quizController = Get.find();

  _delete() async {
    Get.back();
    final response = await _quizController.deleteQuiz(quiz.id);

    if (response['error'] == 1) {
      ConstantManager.showtoast(response['message']);
    } else {
      Get.back();
    }
  }

  _generatePdf() async {
    String pdf = "";

    quiz.questions?.forEach((key, value) {
      pdf += "$key: ${value['Q']}";
      pdf += "\n\n";
      pdf += "A: ${value["A"]}\n";
      pdf += "B: ${value["B"]}\n";
      pdf += "C: ${value["C"]}\n";
      pdf += "D: ${value["D"]}\n";
      pdf += "\n\n\n";
    });

    final pdfFile =
        await PdfApi.generatePdf(header: quiz.title, pdfContent: pdf);

    PdfApi.openFile(pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Quiz.AI'),
      body: Obx(
        () => LoadingOverlay(
          color: ConstantManager.PRIMARY_COLOR,
          progressIndicator: OverlayLoader(),
          isLoading: _quizController.loading.value,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quiz.title ?? "",
                  style: ConstantManager.ktextStyle.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical!),
                Text(
                  quiz.subtitle ?? "",
                  style: ConstantManager.ktextStyle.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical!),
                Text(
                  quiz.date ?? "",
                  style: ConstantManager.ktextStyle.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 3.5),
                _button(
                  text: 'Marking/Grading',
                  onClick: () async {
                    await availableCameras().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraPage(cameras: value))));
                  },
                ),
                _button(
                  text: 'Generate PDF',
                  onClick: _generatePdf,
                ),
                _button(
                  text: 'View Quiz',
                  onClick: () {
                    Get.to(() => ViewQuizScreen(quiz: quiz));
                  },
                ),
                _button(
                  text: 'Delete Quiz',
                  onClick: () {
                    MyConfirmationDialog().showConfirmationDialog(context,
                        message: "Are you sure you want to delete this quiz?",
                        onConfirm: _delete);
                  },
                ),
              ],
            ),
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
