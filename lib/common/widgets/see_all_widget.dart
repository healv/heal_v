import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

class SeeAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback? seeAllPressed;
  final bool loading;

  const SeeAllWidget({
    super.key,
    required this.title,
    required this.seeAllPressed,
  }) : loading = false;

  const SeeAllWidget.loading({
    super.key,
  })  : loading = true,
        title = '',
        seeAllPressed = null;

  @override
  Widget build(BuildContext context) {
    return loading
        ? _loading(context)
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: seeAllPressed,
                child: Text(
                  tr('see_all'),
                  style: TextStyle(fontWeight: FontWeight.w400, color: context.primary),
                ),
              )
            ],
          );
  }

  Widget _loading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 5, child: _shimmer(context)),
        const SizedBox(width: 16),
        Expanded(flex: 1, child: _shimmer(context)),
      ],
    );
  }

  Widget _shimmer(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.onBackground.withOpacity(0.3),
      highlightColor: context.onBackground.withOpacity(0.1),
      child: Container(
        decoration: BoxDecoration(
          color: context.onBackground.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 24,
      ),
    );
  }
}
