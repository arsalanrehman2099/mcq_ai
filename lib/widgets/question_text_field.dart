import 'package:flutter/material.dart';
import 'package:mcq_ai/utils/size_config.dart';

import '../utils/constant_manager.dart';

class QuestionTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;

  QuestionTextField({this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            hint!,
            style: ConstantManager.ktextStyle.copyWith(
                fontSize: SizeConfig.safeBlockHorizontal! * 4.0,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical),
        Container(
          height: SizeConfig.blockSizeVertical! * 20.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal! * 2.0),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }
}
