import 'package:flutter/material.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/common/widget/meditation_card.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';

class MeditationDetailsPage extends StatelessWidget {
  final List<MeditationBreathing> meditations;

  const MeditationDetailsPage({super.key, required this.meditations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.search(
        title: tr('meditation'),
        isBackEnable: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return MeditationCard(items: meditations);
  }
}
