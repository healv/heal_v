import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SeeAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback? seeAllPressed;

  const SeeAllWidget({super.key, required this.title, required this.seeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            tr('see_all'),
            style: TextStyle(fontWeight: FontWeight.w400, color: context.primary),
          ),
        )
      ],
    );
  }
}
