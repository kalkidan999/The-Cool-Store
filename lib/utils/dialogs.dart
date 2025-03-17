import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

import '../config/theme/theme_constants.dart';

class Dialogs {
  Future showInfoDialog(BuildContext context, String message, String dialogtype,
      {int seconds = 30, bool bottomDialog = false}) async {
    final deviceSize = MediaQuery.of(context).size;

    Color color = dialogtype == "warning" || dialogtype == "none"
        ? Colors.orange
        : dialogtype == "error"
            ? error
            : Colors.green[900] ?? Colors.green;
    if (context.mounted) {
      // Check if the widget is still mounted before showing Flushbar
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          Flushbar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flushbarStyle: FlushbarStyle.FLOATING,
            messageText:
                Text(message, style: Theme.of(context).textTheme.bodyMedium),
            boxShadows: [
              BoxShadow(
                  color: color.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 10)
            ],
            dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            flushbarPosition:
                bottomDialog ? FlushbarPosition.BOTTOM : FlushbarPosition.TOP,
            duration: Duration(seconds: seconds),
            icon: SizedBox(
              height: deviceSize.height * 0.1,
              child: VerticalDivider(
                  thickness: deviceSize.width * 0.02, color: color),
            ),
          ).show(context);
        } catch (_) {}
      });
    }
  }
}
