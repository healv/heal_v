import 'package:flutter/material.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SettingDescription extends StatelessWidget {
  const SettingDescription({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      color: context.background,
      child: Text(
        text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
