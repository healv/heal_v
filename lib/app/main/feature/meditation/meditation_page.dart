import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/app/main/feature/meditation/model/meditation_lessons.dart';
import 'package:heal_v/app/main/feature/meditation/model/meditation_week.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/shared/feature/empty/empty_widget.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/alert.dart';
import '../../../../common/utils/constants.dart';
import '../../../../feature/heal_v/api/auth/utils/auth_constants.dart';
import '../../../../navigation/main/meditation/meditation_graph.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Text(
          tr('meditation'),
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
    final meditationPageBloc = context.read<MeditationPageBloc>();
    return Column(
      children: [
        const SizedBox(height: 16),
        _weeks(context, meditationPageBloc),
        const SizedBox(height: 24),
        Expanded(child: _lessons(context, meditationPageBloc)),
      ],
    );
  }

  Widget _weeks(BuildContext context, MeditationPageBloc meditationPageBloc) {
    return BlocSelector<MeditationPageBloc, MeditationPageState, ({List<MeditationWeek> weeks, String? selectedWeekId})>(
      selector: (MeditationPageState state) => (weeks: state.weeks ?? [], selectedWeekId: state.selectedWeekId),
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
                      meditationPageBloc.add(MeditationPageEvent.changeSelectedWeek(id: weeks[index].id ?? emptyString));
                      _tabController.animateTo(index);
                    } else {
                      showLockedDialog(context, tr('meditation_locked'), tr('meditation_locked_description'));
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

  Widget _lessons(BuildContext context, MeditationPageBloc meditationPageBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocSelector<MeditationPageBloc, MeditationPageState, List<MeditationWeek>?>(
        selector: (MeditationPageState state) => state.weeks,
        builder: (BuildContext context, weeks) {
          return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: weeks?.map((week) {
                    return BlocBuilder<MeditationPageBloc, MeditationPageState>(
                      buildWhen: (oldState, newState) => oldState.meditationLessons != newState.meditationLessons || oldState.lessonsLoading != newState.lessonsLoading,
                      builder: (BuildContext context, MeditationPageState state) {
                        if (state.lessonsLoading == true) {
                          return _lessonsShimmer(context);
                        }
                        if (state.meditationLessons == null) {
                          return const SizedBox();
                        }
                        if (state.meditationLessons!.lessons?.isEmpty == true) {
                          return const Center(
                            child: EmptyWidget(),
                          );
                        }
                        return _lessonsGridView(context, week, state.meditationLessons!.lessons!);
                      },
                    );
                  }).toList() ??
                  []);
        },
      ),
    );
  }

  Widget _lessonsGridView(BuildContext context, MeditationWeek week, List<MeditationLesson>? items) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: items?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _lessonItem(context, week, items?[index]);
        // return _image(items?[index].photoUrl);
      },
    );
  }

  Widget _lessonItem(BuildContext context, MeditationWeek week, MeditationLesson? lesson) {
    return InkWell(
      onTap: () {
        if (lesson?.isAccessible == true) {
          MeditationAudioRoute(meditation: jsonEncode(lesson?.toJson())).push(context);
        } else {
          showLockedDialog(context, tr('meditation_locked'), tr('meditation_locked_description'));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: lesson?.isCompleted == true ? context.primary : context.onBackground.withValues(alpha: 0.3)),
          color: context.background,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(context, lesson),
            const SizedBox(height: 12),
            _title(context, lesson),
            const SizedBox(height: 4),
            _duration(context, lesson),
          ],
        ),
      ),
    );
  }

  Widget _lessonsShimmer(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: context.onBackground.withValues(alpha: 0.3),
          highlightColor: context.onBackground.withValues(alpha: 0.1),
          child: Container(
            decoration: BoxDecoration(
              color: context.onBackground.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      },
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
    );
  }

  Widget _image(BuildContext context, MeditationLesson? lesson) {
    return Stack(
      children: [
        Container(
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                lesson?.preview?.url != null ? '${AuthConstants.baseHost}${lesson?.preview?.url}' : emptyString,
              ),
            ),
          ),
        ),
        if (lesson?.isAccessible != true)
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

  Widget _title(BuildContext context, MeditationLesson? lesson) {
    return Text(
      lesson?.title ?? emptyString,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: context.onBackground,
      ),
    );
  }

  Widget _duration(BuildContext context, MeditationLesson? lesson) {
    return Text(
      lesson?.duration != null ? '${lesson!.duration ?? emptyString} ${tr('mins')}' : emptyString,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
        color: context.onBackground.withValues(alpha: 0.3),
      ),
    );
  }
}
