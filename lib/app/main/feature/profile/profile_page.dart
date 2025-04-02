import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/sound_player.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/common/widgets/avatar_widget.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/navigation/main/main_graph.dart';
import 'package:heal_v/navigation/main/profile/profile_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar.simple(
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
                const AvatarWidget(),
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
          const SizedBox(height: 12.0),
          _divider(),
          _progress(context),
          const SizedBox(height: 12.0),
          _divider(),
          _settingsRow(context),
          const SizedBox(height: 12.0),
          _divider(),
          _journalHistory(context),
        ],
      ),
    );
  }

  Widget _userName(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, User?>(
      selector: (AuthBlocState state) => state.user,
      builder: (BuildContext context, User? user) {
        return Text(
          '${user?.name ?? emptyString} ${user?.lastName ?? emptyString}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.onBackground),
        );
      },
    );
  }

  Widget _userJoinedDate(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, User?>(
      selector: (AuthBlocState state) => state.user,
      builder: (BuildContext context, User? user) {
        return Text(
          user?.createdAt != null ? 'Joined ${user?.createdAt}' : emptyString,
          style: TextStyle(fontSize: 14, color: context.onBackground),
        );
      },
    );
  }

  Widget _settings(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        tr('settings'),
        style: TextStyle(fontSize: 16, color: context.textSecondary, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _editProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () async {
          await SoundPlayer.checkAndPlayClickSound();
          ProfileNestedEditProfileRoute().go(context);
        },
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
      child: InkWell(
        onTap: () => ProfileProgressRoute().push(context),
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
      child: InkWell(
        onTap: () async {
          await SoundPlayer.checkAndPlayClickSound();
          ProfileSettingsRoute().push(context);
        },
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
      child: InkWell(
        onTap: () => ProfileJournalHistoryRoute().push(context),
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
