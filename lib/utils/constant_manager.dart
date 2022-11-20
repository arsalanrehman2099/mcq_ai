import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcq_ai/utils/size_config.dart';

import '../widgets/app_logo.dart';

class ConstantManager {
  static const PRIMARY_COLOR = Color(0xffc63d4f);
  static const SECONDARY_COLOR = Color(0xffecf4ff);

  static const APP_ICON_PATH = 'assets/app-icon.png';

  static var ktextStyle = GoogleFonts.montserrat();
  static var kheadStyle = GoogleFonts.fredokaOne();

  static AppBar appBar(text) {
    return AppBar(
      actions: [
        Container(
          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal! * 2.0),
          child: AppLogo(
            w: 30.0,
          ),
        )
      ],
      centerTitle: true,
      title: Text(
        text,
        style: ConstantManager.kheadStyle.copyWith(
            color: ConstantManager.SECONDARY_COLOR,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5),
      ),
      backgroundColor: ConstantManager.PRIMARY_COLOR,
    );
  }

  static BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }

  static showtoast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.white,
      textColor: Colors.grey.shade900,
    );
  }

  static String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
