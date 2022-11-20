import 'package:flutter/material.dart';

import '../utils/constant_manager.dart';

class OverlayLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Colors.white,
      color: ConstantManager.PRIMARY_COLOR,
    );
  }
}