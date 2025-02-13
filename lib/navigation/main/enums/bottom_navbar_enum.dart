import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_v/res/images/app_icons.dart';

enum BottomNavBarEnum {
  home(labelKey: 'home', icon: AppIcons.home),
  meditation(labelKey: 'meditation', icon: AppIcons.meditation),
  stretching(labelKey: 'stretching', icon: AppIcons.stretching),
  breathing(labelKey: 'breathing', icon: AppIcons.breathing),
  profile(labelKey: 'profile', icon: AppIcons.profile);

  final String labelKey;
  final AppIcons icon;

  SvgPicture svgAsset(Color color, [double width = 28, double height = 28]) {
    return icon.svgAsset(width: width, height: height, colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }

  const BottomNavBarEnum({required this.labelKey, required this.icon});
}
