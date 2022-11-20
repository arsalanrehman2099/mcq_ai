import 'package:flutter/material.dart';
import 'package:mcq_ai/utils/constant_manager.dart';

class IconTextField extends StatelessWidget {
  final String? hint;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool secureText;

  IconTextField(
      {this.hint,
        this.icon,
        this.controller,
        this.inputType = TextInputType.text,
        this.secureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ConstantManager.PRIMARY_COLOR,
      controller: controller,
      obscureText: secureText,
      decoration:  InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: ConstantManager.PRIMARY_COLOR,
        ),
        labelText: hint,
        labelStyle: ConstantManager.ktextStyle.copyWith(
          color: Colors.black.withOpacity(0.8),
        ),
      ),
      keyboardType: inputType,
      style: ConstantManager.ktextStyle,
    );
  }
}