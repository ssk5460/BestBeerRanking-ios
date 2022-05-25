import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class DialogUtil {
  static void showAlertDialog(
      {required BuildContext context,
      required String message,
      Function? onPositivePress,
      String? positiveText,
      Function? onNegativePress,
      String? negativeText}) {
    final actions = <Widget>[];
    if (onNegativePress != null) {
      actions.add(MaterialButton(
        onPressed: onNegativePress as void Function()?,
        child: Text(
          negativeText ?? "キャンセル",
          style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
        ),
      ));
    }
    if (onPositivePress != null) {
      actions.add(MaterialButton(
        onPressed: onPositivePress as void Function()?,
        child: Text(positiveText ?? "OK",
            style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16)),
      ));
    } else {
      actions.add(MaterialButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          positiveText ?? "OK",
          style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 16),
        ),
      ));
    }
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
            content: SingleChildScrollView(
              child: Text(message, textScaleFactor: 1),
            ),
            actionsPadding: EdgeInsets.all(0),
            buttonPadding: EdgeInsets.all(0),
            actions: actions);
      },
    );
  }

  static void showActivityIndicatorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
          )),
        );
      },
    );
  }
}
