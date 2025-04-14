import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIcons {
  home('assets/icons/ic_home.svg'),
  breathing('assets/icons/ic_breathing.svg'),
  meditation('assets/icons/ic_meditation.svg'),
  profile('assets/icons/ic_profile.svg'),
  launcher('assets/icons/ic_launcher.png'),
  arrowLeft('assets/icons/ic_arrow_left.svg'),
  arrowRight('assets/icons/ic_arrow_right.svg'),
  tree('assets/icons/tree.png'),
  journal('assets/icons/journal.svg'),
  google('assets/icons/ic_google.svg'),
  demoImage('assets/icons/demo_image.png'),
  demoImage1('assets/icons/demo_image1.png'),
  demoImage2('assets/icons/demo_image2.png'),
  demoImage3('assets/icons/demo_image3.png'),
  icLock('assets/icons/ic_lock.svg'),
  icEmpty('assets/icons/ic_empty.svg'),
  stretching('assets/icons/ic_stretching.svg');

  final String path;

  const AppIcons(this.path);
}

extension IconsExt on AppIcons {
  SvgPicture svgAsset({double? width, double? height, ColorFilter? colorFilter, BoxFit fit = BoxFit.contain}) {
    return SvgPicture.asset(key: ValueKey(path), path, width: width, height: height, colorFilter: colorFilter, fit: fit);
  }

  Image imageAsset({double? width, double? height, BoxFit? fit}) {
    return Image.asset(key: ValueKey(path), path, width: width, height: height, fit: fit);
  }

  AssetImage assetImage() {
    return AssetImage(path);
  }
}
