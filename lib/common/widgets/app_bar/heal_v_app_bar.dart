import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class HealVAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final VoidCallback? onLeadingAction;
  final ValueChanged<String>? onSearchTextChanged;
  final TextEditingController? searchController;
  final bool isBackEnable;
  final bool isSearchEnable;

  const HealVAppBar.search({
    super.key,
    required this.title,
    this.titleStyle,
    this.onLeadingAction,
    this.onSearchTextChanged,
    this.searchController,
    this.isBackEnable = true,
  }) : isSearchEnable = true;

  const HealVAppBar.simple({
    super.key,
    required this.title,
    this.titleStyle,
    this.onLeadingAction,
    this.isBackEnable = true,
  })  : isSearchEnable = false,
        onSearchTextChanged = null,
        searchController = null;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
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
      leading: isBackEnable
          ? IconButton(
              icon: AppIcons.arrowLeft.svgAsset(colorFilter: ColorFilter.mode(context.onBackground, BlendMode.srcIn)),
              onPressed: () => context.pop(),
            )
          : null,
      centerTitle: true,
      title: Text(
        title,
        style: titleStyle ??
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.onBackground,
            ),
      ),
      bottom: isSearchEnable
          ? PreferredSize(
              preferredSize: preferredSize,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: _searchWidget(context),
                ),
              ),
            )
          : null,
    );
  }

  Widget _searchWidget(BuildContext context) {
    return TextField(
      controller: searchController,
      onTapOutside: (_) => context.unFocus(),
      onChanged: onSearchTextChanged,
      decoration: InputDecoration(
        hintText: tr('search'),
        hintStyle: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: context.unselectedItemColor,
        ),
        border: InputBorder.none,
        suffixIcon: Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: context.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(Icons.search, color: Colors.white),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
