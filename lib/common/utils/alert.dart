import 'package:flutter/material.dart';
import 'package:heal_v/application.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/theme/ext/extension.dart';

Future<void> showAlertDialog({required String title, required String message}) async {
  return showDialog(
    context: shellNavigatorGlobalKey.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[Text(message, style: const TextStyle(fontSize: 16))],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(tr('ok'), style: TextStyle(color: context.primary, fontSize: 16)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
