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
  stretching('assets/icons/ic_stretching.svg'),
  replay10('assets/icons/ic_replay_10.svg'),
  forward10('assets/icons/ic_forward_10.svg'),
  play('assets/icons/ic_play.svg'),
  pause('assets/icons/ic_pause.svg'),
  shuffle('assets/icons/ic_shuffle.svg'),
  repeat('assets/icons/ic_repeat.svg'),
  volumeOff('assets/icons/ic_volume_off.svg'),
  volumeOn('assets/icons/ic_volume_on.svg'),
  heart('assets/icons/ic_heart.svg'),
  close('assets/icons/ic_close.svg'),
  fullScreen('assets/icons/ic_full_screen.svg'),
  checked('assets/icons/ic_checked.svg'),
  greenCheckMark('assets/icons/ic_green_check_mark.svg'),
  progress('assets/icons/ic_progress.svg'),
  journalHistory('assets/icons/ic_journal_history.svg'),
  notifications('assets/icons/ic_notifications.svg'),
  logout('assets/icons/ic_logout.svg'),
  logoutDialog('assets/icons/ic_logout_dialog.svg'),
  person('assets/icons/ic_person.svg'),
  gallery('assets/icons/ic_gallery.svg'),
  trash('assets/icons/ic_trash.svg'),
  changePassword('assets/icons/ic_change_password.svg'),
  save('assets/icons/ic_save.svg'),
  share('assets/icons/ic_share.svg'),
  calendar('assets/icons/ic_calendar.svg'),
  clock('assets/icons/ic_clock.svg');

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
