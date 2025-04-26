import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/navigation/main/stretching/stretching_graph.dart';

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
    return Center(
      child: InkWell(
        onTap: () {
          StretchingVideoRoute().push(context);
        },
        child: Text(tr('stretching')),
      ),
    );
  }
}
