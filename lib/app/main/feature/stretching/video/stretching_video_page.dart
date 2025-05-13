import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/video/stretching_video_page_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget.dart';
import 'package:heal_v/theme/ext/extension.dart';

class StretchingVideoPage extends StatefulWidget {
  const StretchingVideoPage({super.key});

  @override
  State<StatefulWidget> createState() => _StretchingVideoPageState();
}

class _StretchingVideoPageState extends State<StretchingVideoPage> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<StretchingVideoPageBloc, StretchingVideoPageState, StretchingLesson?>(
      selector: (StretchingVideoPageState state) => state.stretchingLesson,
      builder: (BuildContext context, StretchingLesson? stretchingLesson) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              stretchingLesson?.title ?? emptyString,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                color: context.onBackground,
              ),
            ),
          ),
          body: _body(context),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return const VideoPlayerWidget();
  }
}
