import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/alert.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  int selectedWeekIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.search(
        title: tr('meditation'),
        isBackEnable: false,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        _weeks(context),
        Expanded(child: _meditations(context)),
      ],
    );
  }

  Widget _meditations(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<MeditationPageBloc, MeditationPageState>(
        builder: (BuildContext context, MeditationPageState state) {
          return state.loading == true ? _meditationsShimmer(context) : _meditationsGridView(context, state.items?.meditationBreathing);
        },
      ),
    );
  }

  Widget _meditationsGridView(BuildContext context, List<MeditationBreathing>? items) {
    return GridView.builder(
      itemBuilder: (context, index) => _image(items?[index].photoUrl),
      itemCount: items?.length ?? 0,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3 / 2,
      ),
    );
  }

  Widget _meditationsShimmer(BuildContext context) {
    return GridView.builder(
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: context.onBackground.withOpacity(0.3),
          highlightColor: context.onBackground.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              color: context.onBackground.withOpacity(0.7),
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

  Widget _image(String? imageUrl) {
    final index = Random().nextInt(5);
    final path = 'assets/icons/ic_meditation_$index.png';
    return imageUrl != null || imageUrl?.isNotEmpty == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(key: ValueKey(path), path, width: 60, height: 60, fit: BoxFit.cover),
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
                showLockedDialog(context, tr('meditation_locked'), tr('meditation_locked_description'));
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
}
