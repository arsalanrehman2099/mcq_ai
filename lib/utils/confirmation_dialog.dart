import 'package:flutter/material.dart';
import 'constant_manager.dart';

class MyConfirmationDialog {
  showConfirmationDialog(BuildContext context, {onConfirm, message}) {
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: ConstantManager.ktextStyle.copyWith(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          )),
      onPressed: () => Navigator.pop(context),
    );
    Widget confirmButton = TextButton(
      onPressed: onConfirm,
      child: Text(
        "Confirm",
        style: ConstantManager.ktextStyle.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation", style: ConstantManager.ktextStyle),
      content: Text(message ?? "",
          style: ConstantManager.ktextStyle),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
