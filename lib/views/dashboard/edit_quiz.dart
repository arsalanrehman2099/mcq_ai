import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/raw_data.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard/new_quiz_questions.dart';
import 'package:mcq_ai/widgets/my_elevated_button.dart';
import 'package:mcq_ai/widgets/my_text_field.dart';

import '../../utils/constant_manager.dart';
import '../../widgets/app_logo.dart';

class EditQuizScreen extends StatefulWidget {

  final int index;
  EditQuizScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<EditQuizScreen> createState() => _EditQuizScreenState();
}

class _EditQuizScreenState extends State<EditQuizScreen> {
  final _title = TextEditingController();
  final _subtitle = TextEditingController();
  final _date = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _title.text = RawData.DATA[widget.index]['title'].toString();
    _subtitle.text = RawData.DATA[widget.index]['subtitle'].toString();
    _date.text = RawData.DATA[widget.index]['date'].toString();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Edit Quiz'),
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
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
