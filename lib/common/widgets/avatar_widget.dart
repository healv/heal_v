import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final double radius;
  final bool isEditable;

  const AvatarWidget({super.key, this.radius = 40.0, this.isEditable = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: const NetworkImage(
            'https://example.com/profile.jpg',
          ),
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
  }
}
