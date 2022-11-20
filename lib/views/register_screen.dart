import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/views/dashboard_screen.dart';
import 'package:mcq_ai/widgets/app_logo.dart';

import '../utils/constant_manager.dart';
import '../utils/size_config.dart';
import '../widgets/my_button.dart';
import '../widgets/my_text_field.dart';

class RegisterScreen extends StatelessWidget {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _cfmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(),
    );
  }

  Widget RegisterForm() {
    return SafeArea(
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
                  SizedBox(height: SizeConfig.blockSizeVertical! ),
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (_){}),
                      Text('Please accept our terms and conditions',style:
                        ConstantManager.ktextStyle.copyWith()),
                    ],
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical! * 2.0),
                  MyButton(text: 'Register', onClick: () => Get.to(()=>DashboardScreen()))
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
