import 'package:flutter/material.dart';
import 'package:heal_v/application.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/res/images/app_icons.dart';
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

Future<void> showLogOutDialog(VoidCallback okClick) async {
  return showDialog(
    context: shellNavigatorGlobalKey.currentContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: context.background,
        icon: AppIcons.logoutDialog.svgAsset(),
        title: Text(
          tr('logout'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: context.onBackground,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.only(top: 8.0, left: 20.0, right: 20.0),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                textAlign: TextAlign.center,
                tr('areYouSureYouWantToLogOut'),
                style: TextStyle(
                  fontSize: 14,
                  color: context.onBackground.withValues(alpha: 0.3),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                tr('youCanAlwaysLogBackInAnytime'),
                style: TextStyle(
                  fontSize: 14,
                  color: context.onBackground.withValues(alpha: 0.3),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.only(top: 24.0, bottom: 20.0),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: context.background,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: context.onBackground.withValues(alpha: 0.2))),
              elevation: 0,
              minimumSize: const Size(129, 36),
            ),
            child: Text(tr('cancel'),
                style: TextStyle(
                  color: context.onBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                )),
          ),
          ElevatedButton(
            onPressed: okClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
              minimumSize: const Size(129, 36),
            ),
            child: Text(tr('logout'),
                style: TextStyle(
                  color: context.background,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                )),
          ),
        ],
      );
    },
  );
}

void showLockedDialog(BuildContext context, String title, String description) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.icLock.svgAsset(height: 100, width: 100),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0XFF999999),
                ),
              ),
              const SizedBox(height: 24),

              // Okay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    tr('okay'),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
