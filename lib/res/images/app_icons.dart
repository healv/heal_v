import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIcons {
  home('assets/icons/ic_home.svg'),
  breathing('assets/icons/ic_breathing.svg'),
  meditation('assets/icons/ic_meditation.svg'),
  profile('assets/icons/ic_profile.svg'),
  launcher('assets/icons/ic_launcher.png'),
  arrowLeft('assets/icons/ic_arrow_left.svg'),
  stretching('assets/icons/ic_stretching.svg');

  final String path;

  const AppIcons(this.path);
}

extension IconsExt on AppIcons {
  SvgPicture svgAsset({double? width, double? height, ColorFilter? colorFilter, BoxFit fit = BoxFit.contain}) {
    return SvgPicture.asset(key: ValueKey(path), path, width: width, height: height, colorFilter: colorFilter, fit: fit);
  }

  Image imageAsset({double? width, double? height}) {
    return Image.asset(key: ValueKey(path), path, width: width, height: height);
  }

  AssetImage assetImage() {
    return AssetImage(path);
  }
}
