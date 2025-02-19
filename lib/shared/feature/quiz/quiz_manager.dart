import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/application.dart';
import 'package:heal_v/shared/feature/quiz/quiz_dialog_content_widget.dart';
import 'package:heal_v/theme/ext/extension.dart';

class QuizManager {
  QuizManager._();

  static void showQuizDialog() {
    final context = shellNavigatorGlobalKey.currentContext!;
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: context.onBackground.withOpacity(0.8),
      builder: (BuildContext context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
            AlertDialog(
              backgroundColor: context.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              contentPadding: const EdgeInsets.all(16),
              content: QuizDialogContentWidget(onDone: () {
                context.pop();
              }),
            ),
          ],
        );
      },
    );
  }
}
