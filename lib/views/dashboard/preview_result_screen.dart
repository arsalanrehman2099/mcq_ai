import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/size_config.dart';

class PreviewResultScreen extends StatefulWidget {
  String? correctAnswer;
  var apiResponse;

  PreviewResultScreen({this.correctAnswer, this.apiResponse});

  @override
  State<PreviewResultScreen> createState() => _PreviewResultScreenState();
}

class _PreviewResultScreenState extends State<PreviewResultScreen> {
  var studentAnswers = '';

  @override
  void initState() {
    super.initState();
    _extractStudentAnswers();
  }

  _extractStudentAnswers() {
    for (var v in widget.apiResponse['student-answer'].values) {
      studentAnswers += (v);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstantManager.appBar('Result'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _stats(),
            Image.network(widget.apiResponse['marked-image']),
          ],
        ),
      ),
    );
  }

  Widget _stats() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal! * 5.0,
          vertical: SizeConfig.blockSizeVertical! * 4.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Marksheet',
              style: ConstantManager.kheadStyle
                  .copyWith(fontSize: SizeConfig.blockSizeHorizontal! * 5.5),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            ListView.separated(
              primary: false,
              shrinkWrap: true,
              itemCount: 11,
              separatorBuilder: (c, _) => SizedBox(
                height: SizeConfig.blockSizeVertical! * 1.5,
              ),
              itemBuilder: (ctx, i) {
                if (i == 0) {
                  return Row(
                    children: [
                      const Expanded(flex: 1, child: Text('#')),
                      Expanded(
                          flex: 4,
                          child: Text(
                            'Correct Answer',
                            style: ConstantManager.ktextStyle
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          flex: 4,
                          child: Text(
                            'Selected Answer',
                            style: ConstantManager.ktextStyle
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(flex: 1, child: Text((i).toString())),
                    Expanded(
                        flex: 4,
                        child: Text(widget.correctAnswer![i - 1] ?? '',
                            textAlign: TextAlign.center,
                            style: ConstantManager.ktextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            ))),
                    Expanded(
                        flex: 4,
                        child: Text(
                          studentAnswers[i - 1] == 'E'? ' - ': studentAnswers[i - 1],
                          textAlign: TextAlign.center,
                          style: ConstantManager.ktextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: widget.correctAnswer![i - 1] ==
                                      studentAnswers[i - 1]
                                  ? Colors.green
                                  : Colors.red),
                        )),
                  ],
                );
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score:',
                  style: ConstantManager.kheadStyle.copyWith(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5.5),
                ),
                Text(
                  "${widget.apiResponse['score']}%   ",
                  style: ConstantManager.ktextStyle.copyWith(
                    fontSize: SizeConfig.blockSizeHorizontal! * 5.5,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
