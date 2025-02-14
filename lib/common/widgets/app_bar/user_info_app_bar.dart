import 'package:flutter/material.dart';
import 'package:heal_v/common/widgets/avatar_widget.dart';
import 'package:heal_v/theme/ext/extension.dart';

class UserInfoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UserInfoAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          Container(
            height: preferredSize.height + 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade100, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  const AvatarWidget(radius: 25, isEditable: false),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Good Moring, Eman! 👋',
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: context.onBackground),
                        ),
                        Text(
                          'Hope your feeling good today.',
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: context.unselectedItemColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
