import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mcq_ai/services/calc_api.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/widgets/my_button.dart';
import 'package:mcq_ai/widgets/my_elevated_button.dart';

import '../../utils/constant_manager.dart';

class PreviewSelectImageScreen extends StatelessWidget {
  File? imageFile;
  String? correctAnswers;

  PreviewSelectImageScreen({this.imageFile, this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Preview Image'),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Image.file(
                imageFile!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
          Expanded(
            flex: 1,
            child: Center(
              child: MyElevatedButton(
                text: 'Calculate Score',
                onClick: () {
                  _showProgressDialog(context);
                  CalculationApi().performCalculation(
                      imageFile: imageFile, correctAnswers: correctAnswers);
                },
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
        ],
      ),
    );
  }

  _showProgressDialog(context) {
    Dialog mediaDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 7.0),
        child: Row(
          children: [
            const CircularProgressIndicator(color: ConstantManager.PRIMARY_COLOR,),
            SizedBox(width: SizeConfig.blockSizeHorizontal! * 3.5),
            Flexible(
              child: Text(
                'Calculating Score.....',
                style: ConstantManager.ktextStyle.copyWith(
                  fontSize: SizeConfig.blockSizeHorizontal! * 3.8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );

    showDialog(
        context: context, builder: (BuildContext context) => mediaDialog);
  }
}
