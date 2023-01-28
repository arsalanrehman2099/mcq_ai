import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/controllers/user_controller.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/raw_data.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/new_quiz.dart';
import 'package:mcq_ai/views/quiz_action_screen.dart';

import '../widgets/app_logo.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButton: _fab(),
      body: ListView.separated(
        itemCount: RawData.DATA.length,
        separatorBuilder: (c, _) => Divider(),
        itemBuilder: (ctx, i) {
          var data = RawData.DATA[i];
          return ListTile(
            onTap: () => Get.to(() => QuizActionScreen(index: i)),
            title: Text(
              data['title'].toString(),
              style: ConstantManager.ktextStyle,
            ),
            subtitle: Text(
              data['subtitle'].toString(),
              style: ConstantManager.ktextStyle,
            ),
            trailing: Text(
              data['date'].toString(),
              style: ConstantManager.ktextStyle,
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar(context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: AppLogo(h: 30),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            MyConfirmationDialog().showConfirmationDialog(context,
                message: 'Are you sure you want to logout?', onConfirm: () {
              _userController.userLogout();
            });
          },
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
        )
      ],
      title: Text(
        'Quiz.AI',
        style: ConstantManager.kheadStyle.copyWith(
            color: ConstantManager.SECONDARY_COLOR,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5),
      ),
      backgroundColor: ConstantManager.PRIMARY_COLOR,
    );
  }

  FloatingActionButton _fab() {
    return FloatingActionButton(
      backgroundColor: ConstantManager.PRIMARY_COLOR,
      onPressed: () => Get.to(() => NewQuizScreen()),
      tooltip: 'New Quiz',
      child: const Icon(Icons.add),
    );
  }
}
