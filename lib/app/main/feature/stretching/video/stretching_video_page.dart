import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/video/stretching_video_page_bloc.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/utils/alert.dart';
import '../../../../../feature/heal_v/api/progress/model/request/daily_progress_request.dart';
import '../../../../../shared/feature/progress/progress_bloc.dart';

class StretchingVideoPage extends StatefulWidget {
  const StretchingVideoPage({super.key});

  @override
  State<StatefulWidget> createState() => _StretchingVideoPageState();
}

class _StretchingVideoPageState extends BlocDependentSideEffectState<StretchingVideoPage, StretchingVideoPageBloc, StretchingVideoPageEffect> {
  StreamSubscription? _videoPlayerEffectsSubscription;

  @override
  void initState() {
    super.initState();
    _videoPlayerEffectsSubscription = context.read<VideoPlayerWidgetBloc>().sideEffects.listen(_listenVideoPlayerEffects);
  }

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

  void _listenVideoPlayerEffects(VideoPlayerWidgetEffect effect) async {
    switch (effect) {
      case VideoPlayerFinished():
        if (context.mounted) context.read<StretchingVideoPageBloc>().add(StretchingVideoPageEvent.lessonFinished());
        break;
    }
  }

  @override
  Future<void> handleSideEffect(StretchingVideoPageEffect effect) async {
    switch (effect) {
      case LessonCompleted():
        await showCompleteLessonDialog();
        if (mounted) {
          context.read<ProgressBloc>().add(ProgressEvent.updateDailyProgress(dailyProgressRequest: DailyProgressRequest(stretching: true)));
          context.pop();
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerEffectsSubscription?.cancel();
  }
}
