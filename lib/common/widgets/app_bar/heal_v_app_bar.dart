import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class HealVAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback? onLeadingAction;
  final bool isBackEnable;

  const HealVAppBar({
    super.key,
    required this.title,
    this.titleStyle,
    this.onLeadingAction,
    this.isBackEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          Container(
            height: preferredSize.height + 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade100, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: titleStyle ??
                    TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.onBackground,
                    ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: isBackEnable
                  ? IconButton(
                      icon: AppIcons.arrowLeft.svgAsset(colorFilter: ColorFilter.mode(context.onBackground, BlendMode.srcIn)),
                      onPressed: () => context.pop(),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
