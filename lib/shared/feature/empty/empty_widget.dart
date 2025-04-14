import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

final class EmptyWidget extends StatelessWidget {
  final bool showIcon;

  const EmptyWidget({
    super.key,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon == true) ...[
              Container(
                width: 150,
                height: 150,
                padding: const EdgeInsets.all(16),
                child: AppIcons.icEmpty.svgAsset(),
              )
            ],
            const SizedBox(height: 8),
            Text(tr('no_data_available'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
