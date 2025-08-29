import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/avatar_widget.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/navigation/main/main_graph.dart';
import 'package:heal_v/navigation/main/profile/profile_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/utils/alert.dart';
import '../../../../common/utils/resource.dart';
import '../../../../navigation/auth/auth_graph.dart';
import '../../../../shared/feature/auth/auth_bloc_effect.dart';
import '../../../../shared/feature/settings/settings_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StreamSubscription? _authEffectsSubscription;

  @override
  void initState() {
    super.initState();
    _authEffectsSubscription = context.read<AuthBloc>().sideEffects.listen(_listenAuthEffects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const AvatarWidget(isEditable: false),
                  const SizedBox(height: 12),
                  _userName(context),
                  const SizedBox(height: 4),
                  _userJoinedDate(context),
                  const SizedBox(height: 8),
                  _editProfile(context),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            _manageSubscriptions(context),
            const SizedBox(height: 12.0),
            _divider(),
            _progress(context),
            const SizedBox(height: 12.0),
            _divider(),
            _journalHistory(context),
            const SizedBox(height: 12.0),
            _divider(),
            _notifications(context),
            const SizedBox(height: 12.0),
            _divider(),
            _sound(context),
            const SizedBox(height: 12.0),
            _divider(),
            _language(context),
            const SizedBox(height: 12.0),
            _divider(),
            _changePassword(context),
            const SizedBox(height: 12.0),
            _divider(),
            _logOut(context),
            const SizedBox(height: 48.0),
            _haveSomeQuestions(context),
            const SizedBox(height: 48.0),
          ],
        ),
      ),
    );
  }

  Widget _haveSomeQuestions(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'support@healvapp.com',
          );

          if (await canLaunchUrl(emailLaunchUri)) {
            await launchUrl(emailLaunchUri);
          }
        },
        child: Text(
          tr('haveSomeQuestions'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: context.primary,
            decoration: TextDecoration.underline,
            decorationColor: context.primary,
          ),
        ),
      ),
    );
  }

  Widget _userName(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, UserDto?>(
      selector: (AuthBlocState state) => state.user,
      builder: (BuildContext context, UserDto? user) {
        return Text(
          '${user?.name ?? emptyString} ${user?.lastName ?? emptyString}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: context.onBackground),
        );
      },
    );
  }

  Widget _userJoinedDate(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, UserDto?>(
      selector: (AuthBlocState state) => state.user,
      builder: (BuildContext context, UserDto? user) {
        return Text(
          user?.createdAt != null ? 'Joined ${DateTime.parse(user!.createdAt!).ddMMM()}' : emptyString,
          style: TextStyle(fontSize: 14, color: context.onBackground.withValues(alpha: 0.3)),
        );
      },
    );
  }

  Widget _editProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.75),
      child: ElevatedButton(
        onPressed: () async {
          if (context.mounted) ProfileNestedEditProfileRoute().go(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primary,
          minimumSize: const Size(129, 36),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tr('edit_profile'),
              style: TextStyle(fontSize: 14, color: context.background, fontWeight: FontWeight.w400, letterSpacing: 0.2),
            ),
            const SizedBox(width: 6),
            AppIcons.arrowRight.svgAsset()
          ],
        ),
      ),
    );
  }

  Widget _changePassword(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () => ProfileChangePasswordRoute().push(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.changePassword.svgAsset(width: 18, height: 18),
                const SizedBox(width: 12),
                Text(
                  tr('changePassword'),
                  style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
                )
              ],
            ),
            AppIcons.arrowRight.svgAsset(colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn))
          ],
        ),
      ),
    );
  }

  Widget _manageSubscriptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () => ProfileManageSubscriptionsRoute().push(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.manageSubscriptions.svgAsset(width: 18, height: 18),
                const SizedBox(width: 12),
                Text(
                  tr('manageSubscriptions'),
                  style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
                )
              ],
            ),
            AppIcons.arrowRight.svgAsset(colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn))
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.progress.svgAsset(width: 18, height: 18),
                const SizedBox(width: 12),
                Text(
                  tr('progress'),
                  style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
                )
              ],
            ),
            AppIcons.arrowRight.svgAsset(colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn))
          ],
        ),
      ),
    );
  }

  Widget _journalHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () async {
          if (context.mounted) ProfileJournalHistoryRoute().push(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.journalHistory.svgAsset(width: 18, height: 18),
                const SizedBox(width: 12),
                Text(
                  tr('journal_history'),
                  style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            AppIcons.arrowRight.svgAsset(colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }

  Widget _notifications(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.notifications.svgAsset(width: 18, height: 18),
              const SizedBox(width: 12),
              Text(
                tr('notifications'),
                style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          BlocSelector<SettingsBloc, SettingsState, bool?>(
            selector: (state) => state.isNotificationsEnable,
            builder: (context, isEnable) {
              return SizedBox(
                width: 42,
                height: 23,
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  value: isEnable ?? false,
                  onChanged: (isChecked) {
                    context.read<SettingsBloc>().add(SettingsEvent.updateNotificationStatus(isEnable: isChecked));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _sound(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcons.volumeOn.svgAsset(
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn),
              ),
              const SizedBox(width: 12),
              Text(
                tr('sound'),
                style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          BlocSelector<SettingsBloc, SettingsState, bool?>(
            selector: (state) => state.isSoundsEnable,
            builder: (context, isEnable) {
              return SizedBox(
                width: 42,
                height: 23,
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  value: isEnable ?? false,
                  onChanged: (isChecked) {
                    context.read<SettingsBloc>().add(SettingsEvent.updateSoundsStatus(isEnable: isChecked));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _language(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () async {
          ProfileLanguageRoute().push(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.journalHistory.svgAsset(width: 18, height: 18),
                const SizedBox(width: 12),
                Text(
                  tr('language'),
                  style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            AppIcons.arrowRight.svgAsset(colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }

  Widget _logOut(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () async {
          showLogOutDialog(() {
            context.read<AuthBloc>().add(AuthBlocEvent.logOut());
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.logout.svgAsset(width: 18, height: 18),
                const SizedBox(width: 12),
                Text(
                  tr('logout'),
                  style: const TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            AppIcons.arrowRight.svgAsset(colorFilter: ColorFilter.mode(context.onBackground.withValues(alpha: 0.2), BlendMode.srcIn)),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Divider());
  }

  void _listenAuthEffects(AuthBlocEffect effect) async {
    switch (effect) {
      case LoggedOut():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            SignInRoute().go(context);
            break;
          case ResourceStatusEnum.error:
            showAlertDialog(title: tr('error'), message: effect.errorMsg.toString());
            break;
          default:
            break;
        }
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _authEffectsSubscription?.cancel();
  }
}
