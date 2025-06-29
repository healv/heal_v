import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum OnboardingIcons {
  onboarding1('assets/icons/ic_onboarding_1.svg'),
  onboarding2('assets/icons/ic_onboarding_2.svg'),
  onboarding3('assets/icons/ic_onboarding_3.svg'),
  onboarding4('assets/icons/ic_onboarding_4.svg'),
  onboarding5('assets/icons/ic_onboarding_5.svg');

  final String path;

  const OnboardingIcons(this.path);
}

extension IconsExt on OnboardingIcons {
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
