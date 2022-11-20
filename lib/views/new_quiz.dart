import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/new_quiz_question.dart';
import 'package:mcq_ai/widgets/my_elevated_button.dart';
import 'package:mcq_ai/widgets/my_text_field.dart';

import '../utils/constant_manager.dart';
import '../widgets/app_logo.dart';

class NewQuizScreen extends StatefulWidget {
  NewQuizScreen({Key? key}) : super(key: key);

  @override
  State<NewQuizScreen> createState() => _NewQuizScreenState();
}

class _NewQuizScreenState extends State<NewQuizScreen> {
  final _title = TextEditingController();
  final _subtitle = TextEditingController();
  final _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('New Quiz'),
      body: _quizForm(),
    );
  }

 
  Widget _quizForm() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Basic Details'.toUpperCase(),
              style: ConstantManager.ktextStyle.copyWith(
                  color: Colors.black,
                  letterSpacing: 1.5,
                  fontSize: SizeConfig.blockSizeHorizontal! * 5.0),
            ),
            const Divider(),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
            MyTextField(
              hint: 'Quiz Title',
              controller: _title,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            MyTextField(
              hint: 'Quiz Subtitle',
              controller: _subtitle,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: ConstantManager.PRIMARY_COLOR, // header background color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            textStyle: ConstantManager.ktextStyle.copyWith(
                              color:  ConstantManager.PRIMARY_COLOR,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2122),
                ).then((value) {
                  if (value != null) {
                    var date =
                        '${value.day} - ${value.month} - ${value.year}';
                    _date.text = date;
                  }
                });
              },
              child: MyTextField(
                hint: 'Select Date',
                controller: _date,
                isEnabled: false,
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
            MyElevatedButton(
              text: 'Next',
              onClick: () => Get.to(() => NewQuizQuestion()),
            ),
          ],
        ),
      ),
    );
  }
}
