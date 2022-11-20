import 'package:flutter/material.dart';

import '../utils/constant_manager.dart';
import '../utils/size_config.dart';

class MyElevatedButton extends StatelessWidget {
  final String? text;
  final void Function()? onClick;

  const MyElevatedButton({super.key, this.text, this.onClick});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return  ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: ConstantManager.PRIMARY_COLOR,
      ),
      child: Text(
        text!.toUpperCase(),
        style: ConstantManager.ktextStyle.copyWith(letterSpacing: 1.2),
      ),
    );
  }

}
