import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page_bloc.dart';
import 'package:heal_v/app/main/feature/breathing/model/breathing_lessons.dart';
import 'package:heal_v/app/main/feature/breathing/model/breathing_week.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/alert.dart';
import '../../../../navigation/main/breathing/breathing_graph.dart';
import '../../../../shared/feature/empty/empty_widget.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<StatefulWidget> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Text(
          tr('breathing'),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: context.onBackground,
          ),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final breathingPageBloc = context.read<BreathingPageBloc>();
    return Column(
      children: [
        const SizedBox(height: 16),
        _weeks(context, breathingPageBloc),
        const SizedBox(height: 24),
        Expanded(child: _lessons(context, breathingPageBloc)),
      ],
    );
  }

  Widget _weeks(BuildContext context, BreathingPageBloc breathingPageBloc) {
    return BlocSelector<BreathingPageBloc, BreathingPageState, ({List<BreathingWeek> weeks, String? selectedWeekId})>(
      selector: (BreathingPageState state) => (weeks: state.weeks ?? [], selectedWeekId: state.selectedWeekId),
      builder: (BuildContext context, record) {
        final weeks = record.weeks;
        final selectedWeekId = record.selectedWeekId;
        _tabController = TabController(length: weeks.length, vsync: this);
        return SizedBox(
          height: 28,
          child: ListView.separated(
            itemCount: weeks.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 12.0),
            itemBuilder: (_, index) {
              final isSelected = weeks[index].id == selectedWeekId;
              return InkWell(
                onTap: () {
                  if (!isSelected) {
                    if (weeks[index].isAccessible == true) {
                      breathingPageBloc.add(BreathingPageEvent.changeSelectedWeek(id: weeks[index].id ?? emptyString));
                      _tabController.animateTo(index);
                    } else {
                      showLockedDialog(context, tr('breathing_locked'), tr('breathing_locked_description'));
                    }
                  }
                },
                child: Container(
                  width: 80,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    color: isSelected ? Colors.pink.shade100 : Colors.transparent,
                    border: isSelected ? null : Border.all(color: Colors.black.withValues(alpha: 0.1)),
                  ),
                  child: Center(
                    child: Text(
                      weeks[index].title ?? emptyString,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: isSelected ? Colors.pink.shade500 : Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _lessons(BuildContext context, BreathingPageBloc breathingPageBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocSelector<BreathingPageBloc, BreathingPageState, List<BreathingWeek>?>(
        selector: (BreathingPageState state) => state.weeks,
        builder: (BuildContext context, weeks) {
          return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: weeks?.map((week) {
                    return BlocBuilder<BreathingPageBloc, BreathingPageState>(
                      buildWhen: (oldState, newState) => oldState.breathingLessons != newState.breathingLessons || oldState.lessonsLoading != newState.lessonsLoading,
                      builder: (BuildContext context, BreathingPageState state) {
                        if (state.lessonsLoading == true) {
                          return _lessonsShimmer(context);
                        }
                        if (state.breathingLessons == null) {
                          return const SizedBox();
                        }
                        if (state.breathingLessons!.lessons?.isEmpty == true) {
                          return const Center(
                            child: EmptyWidget(),
                          );
                        }
                        return _lessonsListView(context, week, state.breathingLessons!.lessons!);
                      },
                    );
                  }).toList() ??
                  []);
        },
      ),
    );
  }

  Widget _lessonsShimmer(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _lessonItemShimmer(context);
      },
      itemCount: 10,
    );
  }

  Widget _lessonItemShimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.onBackground.withValues(alpha: 0.3),
      highlightColor: context.onBackground.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          height: 85,
          decoration: BoxDecoration(
            color: context.onBackground.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _lessonsListView(BuildContext context, BreathingWeek week, List<BreathingLesson> lessons) {
    return ListView.separated(
      itemCount: lessons.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16.0),
      itemBuilder: (_, index) {
        return _lessonItem(context, week, lessons[index]);
      },
    );
  }

  Widget _lessonItem(BuildContext context, BreathingWeek week, BreathingLesson lesson) {
    return InkWell(
      onTap: () {
        if (lesson.isAccessible == true) {
          BreathingAudioRoute(breathing: jsonEncode(lesson.toJson())).push(context);
        } else {
          showLockedDialog(context, tr('breathing_locked'), tr('breathing_locked_description'));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: lesson.isCompleted == true ? Border.all(color: context.primary) : Border.all(color: context.onBackground.withValues(alpha: 0.3)),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _image(lesson),
                const SizedBox(width: 12.0),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _title(lesson),
                    _duration(lesson),
                  ],
                ),
              ],
            ),
            Container(
              width: 24.0,
              height: 24.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lesson.isAccessible != true ? context.onBackground.withValues(alpha: 0.3) : context.primary,
              ),
              child: Center(
                child: AppIcons.play.svgAsset(
                  width: 7.33,
                  height: 9.33,
                  colorFilter: ColorFilter.mode(context.background, BlendMode.srcIn),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _image(BreathingLesson lesson) {
    return Stack(
      children: [
        Container(
          width: 61.0,
          height: 61.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                lesson.preview?.url != null ? '${AuthConstants.baseHost}${lesson.preview?.url}' : emptyString,
              ),
            ),
          ),
        ),
        if (lesson.isAccessible != true)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.onBackground.withValues(alpha: 0.3),
                    context.onBackground.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _title(BreathingLesson lesson) {
    return Text(
      lesson.title ?? emptyString,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16.0,
        color: context.onBackground,
      ),
    );
  }

  Widget _duration(BreathingLesson lesson) {
    return Text(
      lesson.duration != null ? '${lesson.duration ?? emptyString} ${tr('mins')}' : emptyString,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
        color: context.onBackground.withValues(alpha: 0.3),
      ),
    );
  }
}
