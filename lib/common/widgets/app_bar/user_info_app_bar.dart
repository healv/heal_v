import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/avatar_widget.dart';
import 'package:heal_v/feature/heal_v/api/auth/model/user/user_dto.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool loading;

  const UserInfoAppBar({
    super.key,
    required this.title,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return _appBar(context);
  }

  Widget _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 40,
              height: 40,
              child: AvatarWidget(
                radius: 25,
                isEditable: false,
              ),
            ),
            const SizedBox(width: 12),
            loading
                ? _loadingShimmer(context)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocSelector<AuthBloc, AuthBlocState, UserDto?>(
                        selector: (AuthBlocState state) => state.user,
                        builder: (BuildContext context, UserDto? user) {
                          return Text(
                            '${tr('good_morning')}, ${user?.name ?? emptyString}',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                              color: context.onBackground,
                            ),
                          );
                        },
                      ),
                      Text(
                        tr('hope_your_feeling_good_today'),
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                          color: context.onBackground.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _loadingShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Shimmer.fromColors(
        baseColor: context.onBackground.withValues(alpha: 0.3),
        highlightColor: context.onBackground.withValues(alpha: 0.1),
        child: Container(
          color: context.onBackground.withValues(alpha: 0.3),
          height: 24,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
