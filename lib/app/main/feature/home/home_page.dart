import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/sound_player.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/user_info_app_bar.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
import 'package:heal_v/shared/feature/shared_content/shared_content_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

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
    context.read<SharedContentBloc>().add(SharedContentEvent.initial());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedContentBloc, SharedContentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: UserInfoAppBar(
            title: state.appBarMessage ?? emptyString,
            loading: state.loading,
          ),
          body: _body(context),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          _progressCard(context),
          const SizedBox(height: 16.0),
          _forYourJourneyRow(context),
          const SizedBox(height: 16.0),
          _mainListView(context),
        ],
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
            colors: [Colors.pink.shade100, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          tr('perfect_progress'),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: context.onBackground),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Tree Image
                    Column(
                      children: [
                        const Text(
                          "75%",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        AppIcons.tree.imageAsset(width: 210, height: 140),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _legendItem(context, Colors.green, tr('in_progress')),
                  const SizedBox(width: 16),
                  _legendItem(context, Colors.red, tr('complete')),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _forYourJourneyRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tr('for_your_journey'),
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700, color: context.onBackground),
          ),
          TextButton(
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
            },
            child: Text(
              tr('see_all'),
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: context.primary),
            ),
          )
        ],
      ),
    );
  }

  Widget _mainListView(BuildContext context) {
    return BlocBuilder<ProgressBloc, ProgressState>(
      builder: (BuildContext context, ProgressState state) {
        List<ProgressModel> items = [
          ProgressModel(name: tr('meditation'), icon: AppIcons.meditation, isEnabled: state.meditation),
          ProgressModel(name: tr('breathing'), icon: AppIcons.breathing, isEnabled: state.breathing),
          ProgressModel(name: tr('stretching'), icon: AppIcons.stretching, isEnabled: state.stretching),
          ProgressModel(name: tr('journal'), icon: AppIcons.journal, isEnabled: true),
        ];
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => _cardItem(context, items[index], index),
            separatorBuilder: (context, index) => const SizedBox(height: 8.0),
            itemCount: items.length,
          ),
        );
      },
    );
  }

  Widget _cardItem(BuildContext context, ProgressModel item, int index) {
    return InkWell(
      onTap: () async => await _onCardItemTap(context, index, item.isEnabled == true),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          height: 73,
          decoration: BoxDecoration(
            color: item.isEnabled == true ? Colors.white : context.onBackground.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: context.onBackground),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onCardItemTap(BuildContext context, int index, bool isEnabled) async {
    if (!isEnabled) return;
    await SoundPlayer.checkAndPlayClickSound();
    switch (index) {
      case 0:
        GoRouter.of(context).go(MeditationRoute().location);
        break;
      case 1:
        GoRouter.of(context).go(BreathingRoute().location);
        break;
      case 2:
        GoRouter.of(context).go(StretchingRoute().location);
        break;
    }
  }
}

class ProgressModel {
  final String? name;
  final AppIcons? icon;
  final bool? isEnabled;

  const ProgressModel({this.name, this.icon, this.isEnabled});
}
