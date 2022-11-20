import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/views/login_screen.dart';
import 'package:mcq_ai/widgets/overlay_loader.dart';

import '../utils/constant_manager.dart';
import '../utils/size_config.dart';
import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () => Get.off(() => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      body: Stack(
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 40.0,
                width: 40.0,
                child: const CircularProgressIndicator(
                  color: ConstantManager.SECONDARY_COLOR,
                  strokeWidth: 3.0,
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                AppLogo(h: 75.0, w: 75.0),
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 2.0),
                Text(
                  'Quiz.AI',
                  style: ConstantManager.kheadStyle.copyWith(
                      color: ConstantManager.SECONDARY_COLOR,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: SizeConfig.blockSizeHorizontal! * 8.6),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Copyright \u00a9 FYP II - 2022',
                style: ConstantManager.ktextStyle
                    .copyWith(color: ConstantManager.SECONDARY_COLOR),
              ),
            ),
          )
        ],
      ),
    );
  }
}
