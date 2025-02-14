import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/user_info_app_bar.dart';
import 'package:heal_v/navigation/main/breathing/breathing_graph.dart';
import 'package:heal_v/navigation/main/meditation/meditation_graph.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:heal_v/tools/dart/pair.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserInfoAppBar(),
      body: _body(context),
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
            onPressed: () {},
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
    List<Pair<String, AppIcons>> items = [
      Pair(tr('meditation'), AppIcons.meditation),
      Pair(tr('breathing'), AppIcons.breathing),
      Pair(tr('stretching'), AppIcons.stretching),
      Pair(tr('journal'), AppIcons.journal),
    ];
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => _cardItem(context, items[index], index),
        separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        itemCount: items.length,
      ),
    );
  }

  Widget _cardItem(BuildContext context, Pair<String, AppIcons> item, int index) {
    return InkWell(
      onTap: () => _onCardItemTap(index, context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
            height: 73,
            decoration: BoxDecoration(
              color: Colors.white,
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
                    child: item.second.svgAsset(colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  item.first,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: context.onBackground),
                ),
              ],
            )),
      ),
    );
  }

  void _onCardItemTap(int index, BuildContext context) {
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
