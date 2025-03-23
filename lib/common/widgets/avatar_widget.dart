import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final bool isEditable;

  const AvatarWidget({super.key, this.radius = 40.0, this.isEditable = true});

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
              backgroundColor: context.primary,
              backgroundImage: url != null ? NetworkImage(url) : null,
              child: url == null ? Icon(Icons.person, size: radius) : null,
            ),
            if (isEditable)
              const Positioned(
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
      },
    );
  }
}
