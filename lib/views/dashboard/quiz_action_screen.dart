import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mcq_ai/controllers/quiz_controller.dart';
import 'package:mcq_ai/models/quiz.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard/preview_selected_image.dart';
import 'package:mcq_ai/views/dashboard/view_quiz.dart';

import '../../services/pdf_api.dart';
import '../../widgets/overlay_loader.dart';

import 'package:image_picker/image_picker.dart';

class QuizActionScreen extends StatefulWidget {
  QuizActionScreen({Key? key, required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  State<QuizActionScreen> createState() => _QuizActionScreenState();
}

class _QuizActionScreenState extends State<QuizActionScreen> {
  File? imageFile;

  final QuizController _quizController = Get.find();

  _delete() async {
    Get.back();
    final response = await _quizController.deleteQuiz(widget.quiz.id);

    if (response['error'] == 1) {
      ConstantManager.showtoast(response['message']);
    } else {
      Get.back();
    }
  }

  _generatePdf() async {
    String pdf = "";

    widget.quiz.questions?.forEach((key, value) {
      pdf += "$key: ${value['Q']}";
      pdf += "\n\n";
      pdf += "A: ${value["A"]}\n";
      pdf += "B: ${value["B"]}\n";
      pdf += "C: ${value["C"]}\n";
      pdf += "D: ${value["D"]}\n";
      pdf += "\n\n\n";
    });

    final pdfFile =
        await PdfApi.generatePdf(header: widget.quiz.title, pdfContent: pdf);

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
                  widget.quiz.title ?? "",
                  style: ConstantManager.ktextStyle.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical!),
                Text(
                  widget.quiz.subtitle ?? "",
                  style: ConstantManager.ktextStyle.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical!),
                Text(
                  widget.quiz.date ?? "",
                  style: ConstantManager.ktextStyle.copyWith(
                      fontSize: SizeConfig.safeBlockHorizontal! * 3.5),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 3.5),
                _button(
                  text: 'Marking/Grading',
                  onClick: () {
                    _showDialog(context);
                  },
                ),
                _button(
                  text: 'Generate PDF',
                  onClick: _generatePdf,
                ),
                _button(
                  text: 'View Quiz',
                  onClick: () {
                    Get.to(() => ViewQuizScreen(quiz: widget.quiz));
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

  _showDialog(context) {
    Dialog mediaDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 7.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please select from the following option',
              textAlign: TextAlign.center,
              style: ConstantManager.kheadStyle.copyWith(
                fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: _getFromCamera,
                  child: Container(
                    padding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 5.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: SizeConfig.blockSizeHorizontal! * 8.5,
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical!),
                        Text('Camera', style: ConstantManager.ktextStyle),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: _getFromGallery,
                  child: Container(
                    padding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 5.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: SizeConfig.blockSizeHorizontal! * 8.5,
                        ),
                        SizedBox(height: SizeConfig.blockSizeVertical!),
                        Text('Gallery', style: ConstantManager.ktextStyle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => mediaDialog);
  }

  /// Get from gallery
  _getFromGallery() async {
    Get.back();
    ImagePicker()
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          imageFile = File(value.path);
          var correctAnswer = fetchCorrectAnswers();

          Get.to(() => PreviewSelectImageScreen(
            imageFile: imageFile,
            correctAnswers: correctAnswer,
          ));
        });
      } else {
        ConstantManager.showtoast('No Image has been Selected');
      }
    }).catchError((err) {
      ConstantManager.showtoast(err);
    });
  }

  /// Get from camera
  _getFromCamera() async {
    Get.back();
    ImagePicker()
        .pickImage(
      source: ImageSource.camera,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          imageFile = File(value.path);
          var correctAnswer = fetchCorrectAnswers();

          Get.to(() => PreviewSelectImageScreen(
                imageFile: imageFile,
                correctAnswers: correctAnswer,
              ));
        });
      } else {
        ConstantManager.showtoast('No Image has been Captured.');
      }
    }).catchError((err) {
      ConstantManager.showtoast(err);
    });
  }

  fetchCorrectAnswers() {
    var correctAns = '';
    widget.quiz.questions?.forEach((key, value) {
      correctAns += value['Correct'];
    });
    print('CORRECT ANSWERS ---> $correctAns');
    return correctAns;
  }
}
