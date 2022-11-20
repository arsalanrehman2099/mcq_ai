import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/quiz_created.dart';
import 'package:mcq_ai/widgets/question_text_field.dart';

import '../utils/constant_manager.dart';
import '../widgets/my_elevated_button.dart';
import '../widgets/my_text_field.dart';

class NewQuizQuestion extends StatefulWidget {
  const NewQuizQuestion({Key? key}) : super(key: key);

  @override
  State<NewQuizQuestion> createState() => _NewQuizQuestionState();
}

class _NewQuizQuestionState extends State<NewQuizQuestion> {
  int counter = 1;

  final _question = TextEditingController();
  final _a = TextEditingController();
  final _b = TextEditingController();
  final _c = TextEditingController();
  final _d = TextEditingController();

  String dropdownvalue = 'A';

  // List of items in our dropdown menu
  var items = [
    'A',
    'B',
    'C',
    'D',
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Question #$counter'),
      body: QuizForm(),
    );
  }

  Widget QuizForm() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            QuestionTextField(
              hint: 'Question',
              controller: _question,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            OptionTextField(key: 'A', textCtrl: _a),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            OptionTextField(key: 'B', textCtrl: _b),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            OptionTextField(key: 'C', textCtrl: _c),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            OptionTextField(key: 'D', textCtrl: _d),
            SizedBox(height: SizeConfig.blockSizeVertical! * 4.0),
            CorrentOptionDropdown(),
            SizedBox(height: SizeConfig.blockSizeVertical! * 3.0),
            CountNavButtons(),
          ],
        ),
      ),
    );
  }

  Widget CountNavButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyElevatedButton(
          text: 'Prev',
          onClick: () {
            if (counter != 1) {
              setState(() {
                counter = counter - 1;
              });
            }
          },
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal! * 2.5),
        MyElevatedButton(
          text: counter == 10 ? 'Finish' : 'Next',
          onClick: () {
            if (counter != 10) {
              setState(() {
                counter = counter + 1;
              });
            } else {
              MyConfirmationDialog().showConfirmationDialog(context,
                  message: "Are you sure you want to generate this quiz?",
                  onConfirm: () {
                Get.to(() => QuizCreatedScreen());
              });
            }
          },
        )
      ],
    );
  }

  Widget OptionTextField({key, textCtrl}) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 4.0),
            child: Text(
              "$key : ",
              style: ConstantManager.ktextStyle.copyWith(
                  fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(width: SizeConfig.safeBlockHorizontal! * 2.0),
          Expanded(
              child: MyTextField(
            controller: textCtrl,
          )),
        ],
      ),
    );
  }

  Widget CorrentOptionDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Correct Option : ".toUpperCase(),
          style: ConstantManager.ktextStyle.copyWith(
            fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        DropdownButton(
          value: dropdownvalue,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: ConstantManager.ktextStyle,
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownvalue = newValue!;
            });
          },
        ),
      ],
    );
  }
}
