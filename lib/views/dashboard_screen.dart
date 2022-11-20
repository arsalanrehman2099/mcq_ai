import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcq_ai/utils/constant_manager.dart';
import 'package:mcq_ai/utils/raw_data.dart';
import 'package:mcq_ai/utils/size_config.dart';
import 'package:mcq_ai/views/new_quiz.dart';
import 'package:mcq_ai/views/quiz_action_screen.dart';

import '../widgets/app_logo.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: _appBar(),
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

  AppBar _appBar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(15.0),
        child: AppLogo(h: 30),
      ),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
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
