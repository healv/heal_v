import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/alert.dart';
import '../../../../navigation/main/profile/profile_graph.dart';
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
      appBar: AppBar(
        titleSpacing: 16,
        title: Text(
          tr('stretching'),
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
    final stretchingPageBloc = context.read<StretchingPageBloc>();
    return Column(
      children: [
        const SizedBox(height: 16),
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
        return SizedBox(
          height: 28,
          child: ListView.separated(
            itemCount: weeks.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 12.0),
            itemBuilder: (_, index) {
              final isSelected = weeks[index].id == selectedWeekId;
              final week = weeks[index];
              return InkWell(
                onTap: () async {
                  if (!isSelected) {
                    if (week.isAccessible == true) {
                      if (week.requiresSubscription == false || week.hasSubscriptionAccess == true) {
                        stretchingPageBloc.add(StretchingPageEvent.changeSelectedWeek(id: weeks[index].id ?? emptyString, isLoading: true));
                        _tabController.animateTo(index);
                      } else {
                        await showSubscriptionLockedDialog(
                          context,
                          tr('stretching_locked'),
                          tr('subscriptionLockedDialogDescription'),
                          () {
                            ProfileManageSubscriptionsRoute().push(context);
                          },
                        );
                      }
                    } else {
                      showLockedDialog(context, tr('stretching_locked'), tr('stretching_locked_description'));
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
                        return _lessonsListView(context, week, state.stretchingLessons!.lessons!, stretchingPageBloc);
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
          height: 253,
          decoration: BoxDecoration(
            color: context.onBackground.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }

  Widget _lessonsListView(BuildContext context, StretchingWeek week, List<StretchingLesson> lessons, StretchingPageBloc stretchingPageBloc) {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (_, index) {
        return _lessonItem(context, week, lessons[index], stretchingPageBloc);
      },
    );
  }

  Widget _lessonItem(BuildContext context, StretchingWeek week, StretchingLesson lesson, StretchingPageBloc stretchingPageBloc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () async {
          if (lesson.isAccessible == true) {
            if (week.requiresSubscription == false || week.hasSubscriptionAccess == true) {
              StretchingDetailsRoute(
                weekTitle: week.title ?? emptyString,
                weekId: week.id ?? emptyString,
                lessonId: lesson.id ?? emptyString,
              ).push(context).then((value) {
                stretchingPageBloc.add(StretchingPageEvent.getStretchingWeeks(isLoading: false));
              });
            } else {
              await showSubscriptionLockedDialog(
                context,
                tr('stretching_locked'),
                tr('subscriptionLockedDialogDescription'),
                () {
                  ProfileManageSubscriptionsRoute().push(context);
                },
              );
            }
          } else {
            showLockedDialog(context, tr('stretching_locked'), tr('stretching_locked_description'));
          }
        },
        child: Container(
          padding: EdgeInsetsDirectional.zero,
          height: 253,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: lesson.isCompleted == true ? Border.all(color: context.primary, width: 2.0) : null,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            lesson.preview?.url != null ? '${AuthConstants.baseHost}${lesson.preview?.url}' : emptyString,
                          ))),
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
                      '${lesson.poses ?? 0} ${tr('poses')} ${(lesson.duration ?? 0) ~/ 60} ${tr('mins')}',
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
              if (lesson.isCompleted == true)
                Positioned(
                  top: 16.0,
                  right: 16.0,
                  child: AppIcons.checked.svgAsset(width: 24, height: 24),
                ),
              if (lesson.isAccessible != true)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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
          ),
        ),
      ),
    );
  }
}
