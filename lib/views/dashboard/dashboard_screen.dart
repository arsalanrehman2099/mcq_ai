import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mcq_ai/controllers/quiz_controller.dart';
import 'package:mcq_ai/controllers/user_controller.dart';
import 'package:mcq_ai/utils/confirmation_dialog.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/raw_data.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/dashboard/quiz_action_screen.dart';

import '../../models/quiz.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/overlay_loader.dart';
import 'new_quiz.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final UserController _userController = Get.find();
  final QuizController _quizController = Get.find();

  @override
  void initState() {
    super.initState();
    _quizController.fetchQuiz();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButton: _fab(),
      body: Obx(
        () => _quizController.fetchingQuiz.value
            ? Center(child: OverlayLoader())
            : _quizController.quizes.value.isEmpty
                ? _noQuizFound()
                : ListView.separated(
                    itemCount: _quizController.quizes.value.length,
                    separatorBuilder: (c, _) => const Divider(),
                    itemBuilder: (ctx, i) {
                      Quiz quiz = _quizController.quizes.value[i];
                      return ListTile(
                        onTap: () => Get.to(() => QuizActionScreen(quiz: quiz)),
                        title: Text(
                          quiz.title ?? "",
                          style: ConstantManager.ktextStyle,
                        ),
                        subtitle: Text(
                          quiz.subtitle ?? "",
                          style: ConstantManager.ktextStyle,
                        ),
                        trailing: Text(
                          quiz.date ?? "",
                          style: ConstantManager.ktextStyle,
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  Widget _noQuizFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.question_mark,
            size: SizeConfig.safeBlockHorizontal! * 9.0,
          ),
          SizedBox(height: SizeConfig.safeBlockVertical!),
          Text(
            'No Quiz Found',
            style: ConstantManager.kheadStyle.copyWith(
                fontSize: SizeConfig.safeBlockHorizontal! * 4.5,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2),
          ),
        ],
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
