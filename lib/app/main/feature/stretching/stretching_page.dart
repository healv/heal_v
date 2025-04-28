import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/alert.dart';
import '../../../../shared/feature/empty/empty_widget.dart';

class StretchingPage extends StatelessWidget {
  const StretchingPage({super.key});

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
        Expanded(child: _lessons(context, stretchingPageBloc)),
      ],
    );
  }

  Widget _weeks(BuildContext context, StretchingPageBloc stretchingPageBloc) {
    return BlocSelector<StretchingPageBloc, StretchingPageState, List<StretchingWeek>>(
      selector: (StretchingPageState state) => state.weeks ?? [],
      builder: (BuildContext context, List<StretchingWeek> weeks) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(weeks.length, (index) {
              return BlocSelector<StretchingPageBloc, StretchingPageState, String?>(
                selector: (StretchingPageState state) => state.selectedWeekId,
                builder: (BuildContext context, String? selectedWeekId) {
                  final isSelected = weeks[index].id == selectedWeekId;
                  return SizedBox(
                    height: 60,
                    child: GestureDetector(
                      onTap: () {
                        if (stretchingPageBloc.state.stretchingLessons?.isAllLessonsCompleted() == true) {
                          stretchingPageBloc.add(StretchingPageEvent.changeSelectedWeek(id: weeks[index].id ?? emptyString));
                        } else {
                          showLockedDialog(context, tr('stretching_locked'), tr('stretching_locked_description'));
                        }
                      },
                      child: Column(
                        children: [
                          Text('${tr('week')} ${index + 1}', style: TextStyle(color: isSelected ? context.onBackground : context.unselectedItemColor)),
                          if (isSelected)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              height: 2,
                              width: 60,
                              color: context.onBackground,
                            ),
                        ],
                      ),
                    ),
                  );
                },
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
      child: BlocBuilder<StretchingPageBloc, StretchingPageState>(
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
          return _lessonsGridView(context, state.stretchingLessons!.lessons!);
        },
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

  Widget _lessonsGridView(BuildContext context, List<StretchingLesson> lessons) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      itemCount: lessons.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Text(index.toString()),
        );
        // return _image(items?[index].photoUrl);
      },
    );
  }
}
