import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/put_journal/put_journal_bloc.dart';
import 'package:heal_v/app/main/feature/profile/journal_history/put_journal/put_journal_bottom_sheet_dialog.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/sound_player.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/user_info_app_bar.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../navigation/main/quiz/quiz_graph.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFEDE5),
              context.quizDialogItemColor.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(24)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _progressTitleColumn(context),
                        _inProgressColumn(context),
                      ],
                    ),
                    const Spacer(),
                    AppIcons.tree.imageAsset(
                      width: 203,
                      height: 206,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressTitleColumn(BuildContext context) {
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
        BlocSelector<ProgressBloc, ProgressState, TreeGrowthDto?>(
          selector: (ProgressState state) => state.treeGrowth,
          builder: (BuildContext context, TreeGrowthDto? treeGrowth) {
            return Text(
              '${treeGrowth?.progress ?? 0}%',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: context.primary,
              ),
            );
          },
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
        List<ProgressModel> items = [
          ProgressModel(name: tr('meditation'), icon: AppIcons.meditation, isCompleted: state.meditation),
          ProgressModel(name: tr('breathing'), icon: AppIcons.breathing, isCompleted: state.breathing),
          ProgressModel(name: tr('stretching'), icon: AppIcons.stretching, isCompleted: state.stretching),
          ProgressModel(name: tr('journal'), icon: AppIcons.journal, isCompleted: state.journal?.isNotEmpty == true),
          ProgressModel(name: tr('quiz'), isCompleted: state.quiz?.completed == true),
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

  Widget _cardItem(BuildContext context, ProgressModel item, int index) {
    return InkWell(
      onTap: () async => await _onCardItemTap(context, index, item.isCompleted == true),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 73,
          decoration: BoxDecoration(
            border: Border.all(color: item.isCompleted == true ? context.primary.withValues(alpha: 0.3) : context.primary.withValues(alpha: 0.2)),
            color: context.background.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(color: context.primary, shape: BoxShape.circle),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: item.icon?.svgAsset(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    item.name ?? emptyString,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: context.onBackground),
                  ),
                ],
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  border: item.isCompleted == true ? null : Border.all(color: context.quizDialogItemColor),
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
  }

  Future<void>? _onCardItemTap(BuildContext context, int index, bool isCompleted) async {
    if (isCompleted) return;
    await SoundPlayer.checkAndPlayClickSound();
    switch (index) {
      case 0:
        if (context.mounted) GoRouter.of(context).go(MeditationRoute().location);
        break;
      case 1:
        if (context.mounted) GoRouter.of(context).go(BreathingRoute().location);
        break;
      case 2:
        if (context.mounted) GoRouter.of(context).go(StretchingRoute().location);
        break;
      case 3:
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
      case 4:
        if (context.mounted) {
          final progressBloc = context.read<ProgressBloc>();
          if (progressBloc.state.completed == true) {
            QuizRoute().push(context);
            break;
          }
        }
    }
  }
}

class ProgressModel {
  final String? name;
  final AppIcons? icon;
  final bool? isCompleted;

  const ProgressModel({this.name, this.icon, this.isCompleted});
}
