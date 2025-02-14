import 'package:flutter/material.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SettingDescription extends StatelessWidget {
  const SettingDescription({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 0.0, bottom: 16.0, left: 16.0, right: 16.0),
      color: context.background,
      child: Text(
        text,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
      ),
    );
  }
}
