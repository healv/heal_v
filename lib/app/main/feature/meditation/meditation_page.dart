import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/common/widgets/see_all_widget.dart';
import 'package:heal_v/navigation/main/main_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<StatefulWidget> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(
        title: tr('meditation'),
        isBackEnable: false,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: BlocBuilder<MeditationPageBloc, MeditationPageState>(
        builder: (BuildContext context, MeditationPageState state) {
          return state.loading == true ? _meditationMainListViewShimmer(context) : _mainListView(context, state.itemsMap);
        },
      ),
    );
  }

  Widget _mainListView(BuildContext context, Map<String, List<MeditationBreathing>>? items) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeeAllWidget(
                title: 'Explore ${items?.keys.toList()[index]}',
                seeAllPressed: () {
                  MeditationNestedMeditationDetailsRoute(meditations: jsonEncode(items?.values.toList()[index])).push(context);
                },
              ),
              SizedBox(
                height: 293,
                child: ListView.separated(
                  itemBuilder: (context, innerIndex) => _image(items?.values.toList()[index][innerIndex].photoUrl),
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemCount: items?.values.toList()[index].length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: items?.length ?? 0,
    );
  }

  Widget _meditationMainListViewShimmer(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SeeAllWidget.loading(),
              const SizedBox(height: 16),
              _meditationCardListShimmer(),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 24),
      itemCount: 3,
    );
  }

  Widget _image(String? imageUrl) {
    final screenSize = MediaQuery.of(context).size.width;
    final half = screenSize / 2.5;
    return imageUrl != null || imageUrl?.isNotEmpty == true
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl!,
              width: 250,
              height: 292,
              fit: BoxFit.cover,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppIcons.demoImage.imageAsset(width: screenSize - half, height: 292, fit: BoxFit.cover),
          );
  }

  Widget _meditationCardListShimmer() {
    final screenSize = MediaQuery.of(context).size.width;
    final half = screenSize / 2.5;

    Widget shimmer() {
      return Shimmer.fromColors(
        baseColor: context.onBackground.withOpacity(0.3),
        highlightColor: context.onBackground.withOpacity(0.1),
        child: Container(
          width: screenSize - half,
          height: 292,
          decoration: BoxDecoration(
            color: context.onBackground.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemBuilder: (context, index) => shimmer(),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
