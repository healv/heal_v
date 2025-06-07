import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/profile/progress/progress_page_bloc.dart';
import 'package:heal_v/common/extensions/iterable_extension.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/total_progress_dto.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _totalsText(context),
            const SizedBox(height: 8),
            _totalsRow(context, progressPageBloc),
            const SizedBox(height: 16),
            _calendarText(context),
            const SizedBox(height: 8),
            _calendarHeaderWidget(context, progressPageBloc),
            const SizedBox(height: 6),
            _calendarWidget(context, progressPageBloc),
            const SizedBox(height: 16),
            _goalStatusText(context),
            const SizedBox(height: 8),
            _goalsStatusWidget(context),
          ],
        ),
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
    return BlocSelector<ProgressPageBloc, ProgressPageState, TotalProgressDto?>(
      selector: (ProgressPageState state) => state.totalProgress,
      builder: (BuildContext context, TotalProgressDto? totalProgress) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _totalsItem(context, AppIcons.circleBreathing, tr('breathing'), '${totalProgress?.breathing ?? 0}'),
            const SizedBox(width: 12),
            _totalsItem(context, AppIcons.circleMeditation, tr('meditation'), '${totalProgress?.meditation ?? 0}'),
            const SizedBox(width: 12),
            _totalsItem(context, AppIcons.circleStretching, tr('stretching'), '${totalProgress?.stretching ?? 0}'),
          ],
        );
      },
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
        color: context.primary.withValues(alpha: 0.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _calendarHeaderMonthText(context),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  progressPageBloc.add(
                    ProgressPageEvent.previousMonth(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: AppIcons.arrowLeft.svgAsset(
                    width: 6.42,
                    height: 11.17,
                    colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  progressPageBloc.add(
                    ProgressPageEvent.nextMonth(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: AppIcons.arrowRight.svgAsset(
                    width: 6.42,
                    height: 11.17,
                    colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _calendarHeaderMonthText(BuildContext context) {
    return BlocSelector<ProgressPageBloc, ProgressPageState, DateTime>(
        selector: (ProgressPageState state) => state.currentMonth ?? DateTime.now(),
        builder: (BuildContext context, DateTime currentMonth) {
          return Text(
            DateFormat.yMMMM().format(currentMonth),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: context.background,
            ),
          );
        });
  }

  Widget _calendarWidget(BuildContext context, ProgressPageBloc progressPageBloc) {
    return BlocBuilder<ProgressPageBloc, ProgressPageState>(
      buildWhen: (oldState, newState) => oldState.progressList != newState.progressList,
      builder: (BuildContext context, ProgressPageState state) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.primary),
            color: context.primary.withValues(alpha: 0.1),
          ),
          child: TableCalendar(
            rowHeight: 40,
            focusedDay: state.currentMonth ?? DateTime.now(),
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.now(),
            headerVisible: false,
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: false,
              outsideDaysVisible: false,
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                final item = state.progressList?.data?.find((item) => DateTime.parse(item.date!).day == day.day);
                final isAllGoalsCompleted = item?.breathing == true && item?.stretching == true && item?.meditation == true && item?.journal?.isNotEmpty == true;
                final isSomeGoalsCompleted = item?.breathing == true || item?.stretching == true || item?.meditation == true || item?.journal?.isNotEmpty == true;

                if (isAllGoalsCompleted) {
                  return _buildCircle(text: day.day.toString(), fillColor: Colors.green.shade500, textColor: context.background);
                } else if (isSomeGoalsCompleted) {
                  return _buildDashedCircle(text: day.day.toString(), borderColor: const Color(0xFFFFAA33), textColor: context.onBackground);
                } else {
                  return _buildDashedCircle(text: day.day.toString(), borderColor: Colors.red.shade500, textColor: context.onBackground);
                }
              },
              disabledBuilder: (_, day, ___) {
                return _buildCircle(text: day.day.toString(), fillColor: context.background, textColor: context.onBackground);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCircle({required String text, required Color fillColor, required Color textColor}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }

  Widget _buildDashedCircle({required String text, required Color borderColor, required Color textColor}) {
    return SizedBox(
      width: 32,
      height: 32,
      child: DottedBorder(
        options: CircularDottedBorderOptions(
          dashPattern: [3, 3],
          padding: const EdgeInsets.all(7),
          color: borderColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w400,
              fontSize: 12,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _goalStatusText(BuildContext context) {
    return Text(
      tr('goalStatus'),
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        color: context.onBackground,
      ),
    );
  }

  Widget _goalsStatusWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFEAE0)),
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFFFCFA),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _goalStatusRow(context, Colors.red.shade500, tr('youDidNotCompleteAnyGoals')),
          _goalStatusRow(context, Colors.amber.shade500, tr('youCompletedSomeGoals')),
          _goalStatusRow(context, Colors.green.shade500, tr('greatJobAllGoalsCompleted')),
        ],
      ),
    );
  }

  Widget _goalStatusRow(BuildContext context, Color circleColor, String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: context.onBackground,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
