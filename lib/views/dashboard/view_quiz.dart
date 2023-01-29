import 'package:flutter/material.dart';
import 'package:mcq_ai/models/quiz.dart';

import '../../utils/constant_manager.dart';
import '../../utils/size_config.dart';

class ViewQuizScreen extends StatelessWidget {
  final Quiz quiz;

  const ViewQuizScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: ConstantManager.appBar('Display Quiz'),
      body: _quiz(),
    );
  }

  Widget _quiz() {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                quiz.title ?? "",
                style: ConstantManager.ktextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    fontSize: SizeConfig.safeBlockHorizontal! * 4.5),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical),
              Text(
                "(${quiz.subtitle})",
                style: ConstantManager.ktextStyle,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical),
              Text("Date: ${quiz.date}",
                  style: ConstantManager.ktextStyle
                      .copyWith(fontWeight: FontWeight.w700)),
              SizedBox(height: SizeConfig.blockSizeVertical! * 3.5),
              _quizList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _quizList() {
    return ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: quiz.questions!.length,
        separatorBuilder: (ctx, _) => const Divider(),
        itemBuilder: (ctx, i) {
          String key = quiz.questions!.keys.elementAt(i);
          Map ques = quiz.questions![key];

          return Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _text("$key:", "${ques['Q']}"),
                SizedBox(height: SizeConfig.safeBlockVertical!),
                _text("A:", "${ques['A']}"),
                _text("B:", "${ques['B']}"),
                _text("C:", "${ques['C']}"),
                _text("D:", "${ques['D']}"),
                SizedBox(height: SizeConfig.safeBlockVertical!),
                _text("Correct:", "${ques['Correct']}"),
              ],
            ),
          );
        });
  }

  Widget _text(k, v) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(k,
            style: ConstantManager.ktextStyle.copyWith(
              fontWeight: FontWeight.bold,
                letterSpacing: 0.75,
            )),
        SizedBox(width: SizeConfig.safeBlockHorizontal!),
        Flexible(
          child: Text(v, style: ConstantManager.ktextStyle.copyWith(
            letterSpacing: 0.75
          )),
        ),
      ],
    );
  }
}
