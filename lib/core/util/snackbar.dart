import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:taks_3mc/core/theme/theme_constant.dart';

void showSnackBar(BuildContext context, String message) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showFloatingFlushbar(BuildContext context, String? title, String message) {
  Flushbar(
    margin: const EdgeInsets.all(20),
    borderRadius: BorderRadius.circular(8.0),
    backgroundColor: colorPrimary,
    boxShadows: const [
      BoxShadow(
        color: Colors.black,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    message: message,
    duration: const Duration(seconds: 4),
  ).show(context);
}
