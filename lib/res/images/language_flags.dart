import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

enum LanguageFlags {
  russian('assets/flags/ic_russian.svg'),
  english('assets/flags/ic_english.svg');

  final String path;

  const LanguageFlags(this.path);
}

extension IconsExt on LanguageFlags {
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
