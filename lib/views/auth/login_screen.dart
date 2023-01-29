import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mcq_ai/views/auth/register_screen.dart';
import 'package:mcq_ai/widgets/app_logo.dart';

import '../../controllers/user_controller.dart';
import '../../models/user.dart';
import '../../utils/constant_manager.dart';
import '../../utils/size_config.dart';
import '../../widgets/icon_text_field.dart';
import '../../widgets/my_button.dart';
import '../../widgets/overlay_loader.dart';
import '../../widgets/wavy_bg.dart';
import '../dashboard/dashboard_screen.dart';



class LoginScreen extends StatelessWidget {
  final _email = TextEditingController();
  final _pass = TextEditingController();

  final UserController _controller = Get.find();

  LoginScreen({super.key});

  _login() async{
    if (_email.text == "") {
      ConstantManager.showtoast('Email is required');
    } else if (_pass.text == "") {
      ConstantManager.showtoast('Password is required');
    } else if (_pass.text.length < 6) {
      ConstantManager.showtoast('Password must be greater than 6');
    } else {
      final user = User(
        email: _email.text.trim(),
        password: _pass.text.trim(),
      );

      final response = await _controller.userLogin(user);

      if (response['error'] == 1) {
        ConstantManager.showtoast('Error: ' + response['message']);
      } else {
        Get.offAll(() => DashboardScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: LoginBody(context),
    );
  }

  Widget LoginBody(context) {
    return Obx(()=> LoadingOverlay(
      color: ConstantManager.PRIMARY_COLOR,
      progressIndicator: OverlayLoader(),
      isLoading: _controller.loading.value,
      child: Stack(
        children: [
          _wavyBg(),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal! * 6.0,
                    vertical: SizeConfig.blockSizeVertical! * 4.0,
                  ),
                  child: Column(
                    children: [
                      AppLogo(
                        h: SizeConfig.blockSizeVertical! * 15.0,
                        w: SizeConfig.blockSizeVertical! * 15.0,
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 4.5),
                      _credentialBox(),
                      SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
                      _forgotPassword(context),
                      MyButton(text: 'Login', onClick: _login),
                      SizedBox(height: SizeConfig.blockSizeVertical),
                      _signupButton(context),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget _wavyBg() {
    return ClippedPartsWidget(
      top: Container(
        color: ConstantManager.PRIMARY_COLOR,
      ),
      bottom: Container(
        color: Colors.white,
      ),
      splitFunction: (Size size, double x) {
        // normalizing x to make it exactly one wave
        final normalizedX = x / size.width * 2 * pi;
        final waveHeight = size.height / 15;
        final y = size.height / 2 - sin(normalizedX) * waveHeight;

        return y;
      },
    );
  }

  Widget _credentialBox() {
    return Container(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 3.5),
      decoration: ConstantManager.getBoxDecoration(),
      child: Column(
        children: [
          Text(
            'Welcome',
            style: ConstantManager.ktextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.blockSizeHorizontal! * 6.0,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical),
          Text(
            'Please Log in to continue',
            style: ConstantManager.ktextStyle.copyWith(
              fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 1.5),
          const Divider(),
          IconTextField(
            icon: Icons.email,
            hint: 'Email Address',
            inputType: TextInputType.emailAddress,
            controller: _email,
          ),
          const Divider(),
          IconTextField(
            icon: Icons.lock,
            hint: 'Password',
            secureText: true,
            controller: _pass,
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword(context) {
    return GestureDetector(
      // onTap: () => screenNavigation(context, ForgotPasswordScreen()),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical! * 2.0,
          horizontal: SizeConfig.blockSizeHorizontal! * 3.0,
        ),
        margin:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 1.2),
        child: Text(
          'Forgot Password ?',
          style: ConstantManager.ktextStyle.copyWith(color: Colors.black),
        ),
      ),
    );
  }

  Widget _signupButton(context) {
    return GestureDetector(
      onTap: () => Get.to(() => RegisterScreen()),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical! * 2.0,
          horizontal: SizeConfig.blockSizeHorizontal! * 3.0,
        ),
        margin:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 1.2),
        child: Text(
          'Don\'t have an account ? Signup here',
          style: ConstantManager.ktextStyle.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
