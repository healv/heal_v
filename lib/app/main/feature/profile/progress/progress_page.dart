import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/progress/progress_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final progressPageBloc = context.read<ProgressPageBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('progress'),
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: context.onBackground, letterSpacing: 0.2),
        ),
      ),
      body: _body(context, progressPageBloc),
    );
  }

  Widget _body(BuildContext context, ProgressPageBloc progressPageBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _totalsText(context),
          const SizedBox(height: 16),
          _totalsRow(context, progressPageBloc),
          const SizedBox(height: 24),
          _calendarText(context),
          const SizedBox(height: 16),
          _calendarHeaderWidget(context, progressPageBloc),
        ],
      ),
    );
  }

  Widget _totalsText(BuildContext context) {
    return Text(
      tr('totals'),
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: context.onBackground,
      ),
    );
  }

  Widget _totalsRow(BuildContext context, ProgressPageBloc bloc) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //todo remove hardcoded counts
        _totalsItem(context, AppIcons.circleBreathing, tr('breathing'), '2'),
        const SizedBox(width: 12),
        _totalsItem(context, AppIcons.circleMeditation, tr('meditation'), '15'),
        const SizedBox(width: 12),
        _totalsItem(context, AppIcons.circleStretching, tr('stretching'), '20'),
      ],
    );
  }

  Widget _totalsItem(BuildContext context, AppIcons icon, String lessonType, String count) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.quizDialogItemColor.withValues(alpha: 0.3),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon.svgAsset(width: 26, height: 26),
            const SizedBox(height: 8),
            Text(
              lessonType,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.2,
                color: Color(0xFF8F2D00),
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
                color: Color(0xFF8F2D00),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendarText(BuildContext context) {
    return Text(
      tr('calendar'),
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: context.onBackground,
      ),
    );
  }

  Widget _calendarHeaderWidget(BuildContext context, ProgressPageBloc progressPageBloc) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: context.primary.withValues(alpha: 0.3),
      ),
    );
  }
}
