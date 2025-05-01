import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/alert.dart';
import '../../../../shared/feature/empty/empty_widget.dart';

class StretchingPage extends StatefulWidget {
  const StretchingPage({super.key});

  @override
  State<StatefulWidget> createState() => _StretchingPageState();
}

class _StretchingPageState extends State<StretchingPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(
        title: tr('stretching'),
        isBackEnable: false,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    final stretchingPageBloc = context.read<StretchingPageBloc>();
    return Column(
      children: [
        const SizedBox(height: 22),
        _weeks(context, stretchingPageBloc),
        const SizedBox(height: 24),
        Expanded(child: _lessons(context, stretchingPageBloc)),
      ],
    );
  }

  Widget _weeks(BuildContext context, StretchingPageBloc stretchingPageBloc) {
    return BlocSelector<StretchingPageBloc, StretchingPageState, ({List<StretchingWeek> weeks, String? selectedWeekId})>(
      selector: (StretchingPageState state) => (weeks: state.weeks ?? [], selectedWeekId: state.selectedWeekId),
      builder: (BuildContext context, record) {
        final weeks = record.weeks;
        final selectedWeekId = record.selectedWeekId;
        _tabController = TabController(length: weeks.length, vsync: this);
        return Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: SizedBox(
            height: 28,
            child: ListView.builder(
                itemCount: weeks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  final isSelected = weeks[index].id == selectedWeekId;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: InkWell(
                      onTap: () {
                        if (stretchingPageBloc.state.stretchingLessons?.isAllLessonsCompleted() == true) {
                          stretchingPageBloc.add(StretchingPageEvent.changeSelectedWeek(id: weeks[index].id ?? emptyString));
                          _tabController.animateTo(index);
                        } else {
                          showLockedDialog(context, tr('stretching_locked'), tr('stretching_locked_description'));
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
                    ),
                  );
                }),
          ),
        );
      },
    );
  }

  Widget _lessons(BuildContext context, StretchingPageBloc stretchingPageBloc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocSelector<StretchingPageBloc, StretchingPageState, List<StretchingWeek>?>(
        selector: (StretchingPageState state) => state.weeks,
        builder: (BuildContext context, weeks) {
          return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: weeks?.map((week) {
                    return BlocBuilder<StretchingPageBloc, StretchingPageState>(
                      buildWhen: (oldState, newState) => oldState.stretchingLessons != newState.stretchingLessons || oldState.lessonsLoading != newState.lessonsLoading,
                      builder: (BuildContext context, StretchingPageState state) {
                        if (state.lessonsLoading == true) {
                          return _lessonsShimmer(context);
                        }
                        if (state.stretchingLessons == null) {
                          return const SizedBox();
                        }
                        if (state.stretchingLessons!.lessons!.isEmpty) {
                          return const Center(
                            child: EmptyWidget(),
                          );
                        }
                        return _lessonsListView(context, state.stretchingLessons!.lessons!);
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
        return Shimmer.fromColors(
          baseColor: context.onBackground.withValues(alpha: 0.3),
          highlightColor: context.onBackground.withValues(alpha: 0.1),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              height: 253,
              decoration: BoxDecoration(
                color: context.onBackground.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }

  Widget _lessonsListView(BuildContext context, List<StretchingLesson> lessons) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (_, index) {
        return _lessonItem(context, lessons[index]);
      },
    );
  }

  Widget _lessonItem(BuildContext context, StretchingLesson lesson) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 253,
        decoration: BoxDecoration(
          border: lesson.completed == false ? null : Border.all(color: context.primary),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    // todo Remove hardcoded photo
                    'https://media.istockphoto.com/id/1310511832/photo/asian-woman-stretching-her-back-in-a-training-gym.jpg?s=1024x1024&w=is&k=20&c=mPm3qGkYFAts-30ewEZ9HiIUB_ZUE7ZXNPJZh-ygq3s=',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${lesson.title}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: context.background,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    '${lesson.poses} ${tr('poses')} ${lesson.duration} ${tr('mins')}',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: context.background,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            if (lesson.completed == true)
              Positioned(
                top: 16.0,
                right: 16.0,
                child: AppIcons.stretchingCompleted.svgAsset(width: 24, height: 24),
              )
          ],
        ),
      ),
    );
  }
}
