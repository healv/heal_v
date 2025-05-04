import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final bool isEditable;
  final VoidCallback? onEditClick;

  const AvatarWidget({super.key, this.radius = 50.0, this.isEditable = true, this.onEditClick});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthBlocState, String?>(
      selector: (AuthBlocState state) => state.user?.photoURL,
      builder: (BuildContext context, String? url) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: radius,
              backgroundColor: context.onBackground.withValues(alpha: 0.2),
              backgroundImage: (url != null && url.isNotEmpty) ? NetworkImage(url) : null,
              child: url == null || url.isEmpty
                  ? ClipOval(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: AppIcons.person.svgAsset(
                                colorFilter: ColorFilter.mode(
                                  context.onBackground.withValues(alpha: 0.3),
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : null,
            ),
            if (isEditable)
              Positioned(
                bottom: 0,
                right: 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.background,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2, top: 2),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: context.primary,
                        child: InkWell(onTap: onEditClick, child: Icon(Icons.edit, color: context.background, size: 16)),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
