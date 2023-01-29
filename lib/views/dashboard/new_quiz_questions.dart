import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mcq_ai/controllers/quiz_controller.dart';
import 'package:mcq_ai/models/quiz.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard/quiz_created.dart';
import 'package:mcq_ai/widgets/question_text_field.dart';

import '../../utils/constant_manager.dart';
import '../../widgets/my_elevated_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/overlay_loader.dart';

class NewQuizQuestion extends StatefulWidget {
  final Quiz quiz;

  const NewQuizQuestion({super.key, required this.quiz});

  @override
  State<NewQuizQuestion> createState() => _NewQuizQuestionState();
}

class _NewQuizQuestionState extends State<NewQuizQuestion> {
  int counter = 1;
  int max = 10;

  final QuizController _quizController = Get.find();

  var questions = {};

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

  _prev() {
    if (counter != 1) {
      setState(() {
        counter = counter - 1;
        _question.text = questions[counter.toString()]['Q'];
        _a.text = questions[counter.toString()]['A'];
        _b.text = questions[counter.toString()]['B'];
        _c.text = questions[counter.toString()]['C'];
        _d.text = questions[counter.toString()]['D'];
        dropdownvalue = questions[counter.toString()]['Correct'];
      });
    }
  }

  _next() {
    if (_question.text == "" ||
        _a.text == "" ||
        _b.text == "" ||
        _c.text == "" ||
        _d.text == "") {
      ConstantManager.showtoast('Please fill all fields');
    } else {
      questions[counter.toString()] = {
        'Q': _question.text,
        'A': _a.text,
        'B': _b.text,
        'C': _c.text,
        'D': _d.text,
        'Correct': dropdownvalue
      };
      if (counter != max) {
        setState(() => counter = counter + 1);
        if (questions.containsKey(counter.toString())) {
          _question.text = questions[counter.toString()]['Q'];
          _a.text = questions[counter.toString()]['A'];
          _b.text = questions[counter.toString()]['B'];
          _c.text = questions[counter.toString()]['C'];
          _d.text = questions[counter.toString()]['D'];
          dropdownvalue = questions[counter.toString()]['Correct'];
        } else {
          _question.text = "";
          _a.text = "";
          _b.text = "";
          _c.text = "";
          _d.text = "";
          dropdownvalue = 'A';
        }
      } else {
        MyConfirmationDialog().showConfirmationDialog(
          context,
          message: "Are you sure you want to generate this quiz?",
          onConfirm: () async {
            widget.quiz.questions = questions;
            Get.back();

            final response = await _quizController.createQuiz(widget.quiz);

            if (response['error'] == 1) {
              ConstantManager.showtoast(response['message']);
            } else {
              Get.offAll(() => QuizCreatedScreen(quiz: widget.quiz));
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Question #$counter'),
      body: Obx(
        () => LoadingOverlay(
          color: ConstantManager.PRIMARY_COLOR,
          progressIndicator: OverlayLoader(),
          isLoading: _quizController.loading.value,
          child: QuizForm(),
        ),
      ),
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
          onClick: _prev,
        ),
        SizedBox(width: SizeConfig.safeBlockHorizontal! * 2.5),
        MyElevatedButton(
          text: counter == max ? 'Finish' : 'Next',
          onClick: _next,
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
