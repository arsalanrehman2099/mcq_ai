import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mcq_ai/controllers/user_controller.dart';
import 'package:mcq_ai/models/user.dart';
import 'package:mcq_ai/widgets/app_logo.dart';

import '../../utils/constant_manager.dart';
import '../../utils/size_config.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../../widgets/overlay_loader.dart';
import '../dashboard/dashboard_screen.dart';

class RegisterScreen extends StatelessWidget {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _cfmPass = TextEditingController();

  final UserController _controller = Get.find();

  _register() async {
    if (_name.text == "") {
      ConstantManager.showtoast('Name is required');
    } else if (_email.text == "") {
      ConstantManager.showtoast('Email is required');
    } else if (_pass.text == "") {
      ConstantManager.showtoast('Password is required');
    } else if (_pass.text.length < 6) {
      ConstantManager.showtoast('Password must be greater than 6');
    } else if (_cfmPass.text == "") {
      ConstantManager.showtoast('Confirm Password is required');
    } else if (_cfmPass.text != _pass.text) {
      ConstantManager.showtoast('Password Mismatch');
    } else {
      final user = User(
          name: _name.text.trim(),
          email: _email.text.trim(),
          password: _pass.text.trim(),
          createdAt: Timestamp.now());

      final response = await _controller.userSignup(user);

      if (response['error'] == 1) {
        ConstantManager.showtoast('Error: '+response['message']);
      } else {
        Get.offAll(() => DashboardScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }

  Widget RegisterForm() {
    return Obx(() => LoadingOverlay(
      color: ConstantManager.PRIMARY_COLOR,
      progressIndicator: OverlayLoader(),
      isLoading: _controller.loading.value,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: const BackButton()),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical! * 5.0,
                  horizontal: SizeConfig.blockSizeHorizontal! * 4.5,
                ),
                child: Column(
                  children: [
                    _header(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3.5),
                    MyTextField(hint: 'Full Name', controller: _name),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.2),
                    MyTextField(
                      hint: 'Email Address',
                      controller: _email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.2),
                    MyTextField(
                        hint: 'Password', hideText: true, controller: _pass),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.2),
                    MyTextField(
                        hint: 'Confirm Password',
                        hideText: true,
                        controller: _cfmPass),
                    SizedBox(height: SizeConfig.blockSizeVertical!),
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        Text('Please accept our terms and conditions',
                            style: ConstantManager.ktextStyle.copyWith()),
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                    MyButton(text: 'Register', onClick: _register)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Sign up',
          style: ConstantManager.ktextStyle.copyWith(
            color: Colors.black,
            fontSize: SizeConfig.blockSizeHorizontal! * 8.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppLogo(
          h: SizeConfig.blockSizeVertical! * 15.0,
          w: SizeConfig.blockSizeVertical! * 15.0,
        ),
      ],
    );
  }
}
