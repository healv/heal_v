import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/home/model/daily_goal_enum.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/put_journal/put_journal_bloc.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/put_journal/put_journal_bottom_sheet_dialog.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/sound_player.dart';
import 'package:heal_v/common/widgets/app_bar/user_info_app_bar.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../common/utils/alert.dart';
import '../../../../feature/heal_v/api/auth/utils/auth_constants.dart';
import '../../../../navigation/main/quiz/quiz_graph.dart';
import 'model/daily_goal_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProgressBloc>().add(ProgressEvent.initial());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const UserInfoAppBar(),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _progressCard(context),
            const SizedBox(height: 16.0),
            _dailyGoals(context),
            const SizedBox(height: 16.0),
            _cards(context),
          ],
        ),
      ),
    );
  }

  Widget _progressCard(BuildContext context) {
    return BlocSelector<ProgressBloc, ProgressState, TreeGrowthDto?>(
        selector: (ProgressState state) => state.treeGrowth,
        builder: (BuildContext context, TreeGrowthDto? treeGrowth) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      height: 16.0,
                      width: 16.0,
                      decoration: BoxDecoration(
                        image: treeGrowth?.progressImg != null
                            ? DecorationImage(
                                image: NetworkImage(
                                  '${AuthConstants.baseHost}${treeGrowth?.progressImg}',
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _progressTitleColumn(context, treeGrowth),
                          _inProgressColumn(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _progressTitleColumn(BuildContext context, TreeGrowthDto? treeGrowth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('progress'),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: context.primary.withValues(alpha: 0.5),
          ),
        ),
        Text(
          '${treeGrowth?.progress ?? 0}%',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: context.primary,
          ),
        ),
      ],
    );
  }

  Widget _inProgressColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _legendItem(context, Colors.green, tr('in_progress')),
        const SizedBox(width: 16),
        _legendItem(context, Colors.green, tr('growing')),
      ],
    );
  }

  Widget _legendItem(BuildContext context, Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 10, color: context.onBackground)),
      ],
    );
  }

  Widget _dailyGoals(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        tr('daily_goals'),
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: context.onBackground),
      ),
    );
  }

  Widget _cards(BuildContext context) {
    return BlocBuilder<ProgressBloc, ProgressState>(
      buildWhen: (oldState, newState) =>
          oldState.meditation != newState.meditation || oldState.breathing != newState.breathing || oldState.stretching != newState.stretching || oldState.journal != newState.journal,
      builder: (BuildContext context, ProgressState state) {
        List<DailyGoalModel> items = [
          DailyGoalModel(dailyGoalEnum: DailyGoalEnum.meditation, title: tr('meditation'), icon: AppIcons.meditation, isCompleted: state.meditation ?? false),
          DailyGoalModel(dailyGoalEnum: DailyGoalEnum.breathing, title: tr('breathing'), icon: AppIcons.breathing, isCompleted: state.breathing ?? false),
          DailyGoalModel(dailyGoalEnum: DailyGoalEnum.stretching, title: tr('stretching'), icon: AppIcons.stretching, isCompleted: state.stretching ?? false),
          DailyGoalModel(dailyGoalEnum: DailyGoalEnum.journal, title: tr('journal'), icon: AppIcons.journal, isCompleted: state.journal?.isNotEmpty == true),
          DailyGoalModel(dailyGoalEnum: DailyGoalEnum.quiz, title: tr('dailyQuiz'), icon: AppIcons.dailyQuiz, isCompleted: state.quiz?.completed == true),
        ];

        return Column(
          children: items.mapIndexed((index, item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _cardItem(context, item, index),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _cardItem(BuildContext context, DailyGoalModel item, int index) {
    return BlocSelector<ProgressBloc, ProgressState, bool?>(
      selector: (ProgressState state) => state.dailyGoalsCompleted,
      builder: (BuildContext context, bool? dailyGoalsCompleted) {
        return InkWell(
          onTap: () async => await _onCardItemTap(context, item, dailyGoalsCompleted == true),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 73,
              decoration: BoxDecoration(
                border: _border(context, item, dailyGoalsCompleted == true),
                color: context.background.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      _icon(context, item, dailyGoalsCompleted == true),
                      const SizedBox(width: 16),
                      _title(context, item, dailyGoalsCompleted == true),
                    ],
                  ),
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      border: _checkMarkBorder(context, item, dailyGoalsCompleted == true),
                      shape: BoxShape.circle,
                      color: item.isCompleted == true ? context.primary : context.background,
                    ),
                    child: item.isCompleted == true ? Center(child: AppIcons.checkMark.svgAsset()) : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void>? _onCardItemTap(BuildContext context, DailyGoalModel item, bool dailyGoalsCompleted) async {
    if (item.isCompleted == true) return;
    await SoundPlayer.checkAndPlayClickSound();
    switch (item.dailyGoalEnum) {
      case DailyGoalEnum.meditation:
        if (context.mounted) GoRouter.of(context).go(MeditationRoute().location);
        break;
      case DailyGoalEnum.breathing:
        if (context.mounted) GoRouter.of(context).go(BreathingRoute().location);
        break;
      case DailyGoalEnum.stretching:
        if (context.mounted) GoRouter.of(context).go(StretchingRoute().location);
        break;
      case DailyGoalEnum.journal:
        if (context.mounted) {
          showModalBottomSheet<PutJournalEffect>(
              backgroundColor: context.background,
              context: context,
              builder: (context) {
                return BlocProvider(
                  create: (_) => PutJournalBloc()..add(PutJournalEvent.initial()),
                  child: const PutJournalBottomSheetDialog(),
                );
              });
        }
        break;
      case DailyGoalEnum.quiz:
        if (context.mounted) {
          if (dailyGoalsCompleted == true) {
            QuizRoute().push(context);
            break;
          } else {
            await showLockedDialog(context, tr('dailyQuiz'), tr('dailyQuizLockedDialogDescription'));
          }
        }
    }
  }

  Border _border(BuildContext context, DailyGoalModel item, bool dailyGoalsCompleted) {
    switch (item.dailyGoalEnum) {
      case DailyGoalEnum.meditation || DailyGoalEnum.breathing || DailyGoalEnum.stretching || DailyGoalEnum.journal:
        return Border.all(color: item.isCompleted == true ? context.primary.withValues(alpha: 0.3) : context.primary.withValues(alpha: 0.2));
      case DailyGoalEnum.quiz:
        return Border.all(
            color: !dailyGoalsCompleted
                ? context.onBackground.withValues(alpha: 0.2)
                : item.isCompleted == true
                    ? context.primary.withValues(alpha: 0.3)
                    : context.primary.withValues(alpha: 0.2));
    }
  }

  Border? _checkMarkBorder(BuildContext context, DailyGoalModel item, bool dailyGoalsCompleted) {
    switch (item.dailyGoalEnum) {
      case DailyGoalEnum.meditation || DailyGoalEnum.breathing || DailyGoalEnum.stretching || DailyGoalEnum.journal:
        return item.isCompleted == true ? null : Border.all(color: context.quizDialogItemColor);

      case DailyGoalEnum.quiz:
        return !dailyGoalsCompleted
            ? Border.all(color: context.onBackground.withValues(alpha: 0.2))
            : item.isCompleted == true
                ? null
                : Border.all(color: context.quizDialogItemColor);
    }
  }

  Widget _icon(BuildContext context, DailyGoalModel item, bool dailyGoalsCompleted) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: switch (item.dailyGoalEnum) {
          DailyGoalEnum.quiz => dailyGoalsCompleted ? context.primary : context.onBackground.withValues(alpha: 0.3),
          _ => context.primary,
        },
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: item.icon.svgAsset(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      ),
    );
  }

  Widget _title(BuildContext context, DailyGoalModel item, bool dailyGoalsCompleted) {
    return Text(
      item.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: dailyGoalsCompleted == true ? context.onBackground : context.onBackground.withValues(alpha: 0.3),
      ),
    );
  }
}
