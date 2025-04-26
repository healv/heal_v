import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget.dart';
import 'package:heal_v/res/images/app_icons.dart';

class StretchingVideoPage extends StatefulWidget {
  const StretchingVideoPage({super.key});

  @override
  State<StatefulWidget> createState() => _StretchingVideoPageState();
}

class _StretchingVideoPageState extends State<StretchingVideoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: AppIcons.close.svgAsset(),
            ),
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return const VideoPlayerWidget();
  }
}
