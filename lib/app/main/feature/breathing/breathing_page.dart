import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page_bloc.dart';
import 'package:heal_v/app/main/feature/common/widget/meditation_breathing_categories_widget.dart';
import 'package:heal_v/app/main/feature/common/widget/meditation_card.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../common/tools/sound_player.dart';
import '../../../../common/utils/alert.dart';
import '../../../../shared/feature/empty/empty_widget.dart';

class BreathingPage extends StatefulWidget {
  const BreathingPage({super.key});

  @override
  State<StatefulWidget> createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {
  int selectedWeekIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.search(
        title: tr('breathing'),
        isBackEnable: false,
        onSearchTextChanged: (value) {
          context.read<BreathingPageBloc>().add(BreathingPageEvent.breathings(searchQuery: value));
        },
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _weeks(context),
        Expanded(child: _breathings(context)),
      ],
    );
  }

  Widget _breathings(BuildContext context) {
    return BlocBuilder<BreathingPageBloc, BreathingPageState>(
      builder: (context, state) {
        if (state.loading == true) {
          return MeditationCard.loading();
        }
        if (state.items == null) {
          return const SizedBox();
        }
        if (state.items!.meditationBreathing!.isEmpty) {
          return const Center(
            child: EmptyWidget(),
          );
        }
        return MeditationCard(items: state.items?.meditationBreathing ?? []);
      },
    );
  }

  Widget _weeks(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          final isSelected = index == selectedWeekIndex;
          return SizedBox(
            height: 60,
            child: GestureDetector(
              onTap: () {
                showLockedDialog(context, tr('breathing_locked'), tr('breathing_locked_description'));
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
        }),
      ),
    );
  }

  Widget _categories(BuildContext context) {
    return BlocBuilder<BreathingPageBloc, BreathingPageState>(
      builder: (BuildContext context, BreathingPageState state) {
        final categories = state.categories;
        return SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: state.categoriesLoading == true
                ? const MeditationBreathingCategoriesWidget.loading()
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () async {
                        await SoundPlayer.checkAndPlayClickSound();
                        final bloc = context.read<BreathingPageBloc>();
                        bloc.add(BreathingPageEvent.updateCategory(category: categories![index]));
                        bloc.add(BreathingPageEvent.filterByCategory(category: categories[index]));
                      },
                      child: MeditationBreathingCategoriesWidget(
                        name: categories?[index].name ?? emptyString,
                        id: categories?[index].id ?? emptyString,
                        selected: state.selectedCategory == categories?[index],
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(width: 8.0),
                    itemCount: categories?.length ?? 0,
                  ),
          ),
        );
      },
    );
  }
}
