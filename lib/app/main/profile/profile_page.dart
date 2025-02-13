import 'package:flutter/material.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/theme/ext/extension.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      appBar: HealVAppBar(
        title: tr('profile'),
        isBackEnable: false,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                _avatar(),
                const SizedBox(height: 12),
                _userName(context),
                const SizedBox(height: 4),
                _userJoinedDate(context),
                const SizedBox(height: 32),
              ],
            ),
          ),
          _settings(context),
          _editProfile(context),
          _divider(),
          _progress(context),
          _divider(),
          _settingsRow(context),
          _divider(),
          _journalHistory(context),
        ],
      ),
    );
  }

  Widget _avatar() {
    return const Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
            'https://example.com/profile.jpg',
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE582DE),
            child: Icon(Icons.edit, color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _userName(BuildContext context) {
    return Text(
      "Eman Elhadedy",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.onBackground),
    );
  }

  Widget _userJoinedDate(BuildContext context) {
    return Text(
      "Joined 12 Feb",
      style: TextStyle(fontSize: 14, color: context.onBackground),
    );
  }

  Widget _settings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        tr('settings'),
        style: const TextStyle(fontSize: 16, color: Color(0xFF999999), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _editProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('edit_profile'),
              style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
            ),
            AppIcons.arrowRight.svgAsset()
          ],
        ),
      ),
    );
  }

  Widget _progress(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('progress'),
              style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
            ),
            AppIcons.arrowRight.svgAsset()
          ],
        ),
      ),
    );
  }

  Widget _settingsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('settings'),
              style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
            ),
            AppIcons.arrowRight.svgAsset()
          ],
        ),
      ),
    );
  }

  Widget _journalHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('journal_history'),
              style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
            ),
            AppIcons.arrowRight.svgAsset()
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Divider());
  }
}
