import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar(title: tr('progress'), isBackEnable: true),
      body: const Text('data'),
    );
  }
}
