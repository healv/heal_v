import 'dart:async';

import 'package:flutter/material.dart' show AppBar, Colors, Scaffold;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/common/model/lesson_result_type_enum.dart';
import 'package:heal_v/app/main/feature/common/model/lesson_type_enum.dart';
import 'package:heal_v/app/main/feature/media/audio/audio_page_bloc.dart';
import 'package:heal_v/common/widgets/media/audio/audio_player_widget_bloc.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/request/daily_progress_request.dart';
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../common/flutter/widgets/framework.dart';
import '../../../../../common/utils/alert.dart';
import '../../../../../common/widgets/media/audio/audio_player_widget.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<StatefulWidget> createState() => _AudioPageState();
}

class _AudioPageState extends BlocDependentSideEffectState<AudioPage, AudioPageBloc, AudioPageSideEffect> {
  StreamSubscription? _audioPlayerEffectsSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayerEffectsSubscription = context.read<AudioPlayerWidgetBloc>().sideEffects.listen(_listenAudioPlayerEffects);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.onBackground),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _image(),
              const SizedBox(height: 24),
              _title(context),
              const SizedBox(height: 8),
              _description(context),
              const SizedBox(height: 40),
              _audioWidget(context),
              const SizedBox(height: 78),
            ],
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return BlocSelector<AudioPageBloc, AudioPageState, String?>(
      selector: (AudioPageState state) => state.previewUrl,
      builder: (BuildContext context, String? previewUrl) {
        if (previewUrl != null) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 332,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                previewUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _title(BuildContext context) {
    return BlocSelector<AudioPageBloc, AudioPageState, String?>(
      selector: (AudioPageState state) => state.title,
      builder: (BuildContext context, String? title) {
        if (title != null) {
          return Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: context.onBackground,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _description(BuildContext context) {
    return BlocSelector<AudioPageBloc, AudioPageState, String?>(
      selector: (AudioPageState state) => state.description,
      builder: (BuildContext context, String? description) {
        if (description != null) {
          return Text(
            description,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: context.onBackground.withValues(alpha: 0.6),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _audioWidget(BuildContext context) {
    return BlocSelector<AudioPageBloc, AudioPageState, String?>(
      selector: (AudioPageState state) => state.title,
      builder: (BuildContext context, String? title) {
        return title != null ? const AudioPlayerWidget() : const SizedBox.shrink();
      },
    );
  }

  void _listenAudioPlayerEffects(AudioPlayerWidgetEffect effect) async {
    switch (effect) {
      case AudioPlayerStateChanged():
        if (effect.playerState == ProcessingState.completed) {
          if (context.mounted) context.read<AudioPageBloc>().add(AudioPageEvent.lessonCompleted(loopMode: effect.loopMode));
        }
        break;
    }
  }

  @override
  Future<void> handleSideEffect(AudioPageSideEffect effect) async {
    switch (effect) {
      case LessonCompletedEffect():
        if (effect.loopMode == LoopMode.off) {
          await showCompleteLessonDialog();
          if (mounted) {
            context.read<ProgressBloc>().add(
              ProgressEvent.updateDailyProgress(
                dailyProgressRequest: DailyProgressRequest(
                  meditation: effect.lessonTypeEnum == LessonTypeEnum.meditation ? true : null,
                  breathing: effect.lessonTypeEnum == LessonTypeEnum.breathing ? true : null,
                ),
              ),
            );
            context.pop(LessonResultTypeEnum.completed);
          }
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayerEffectsSubscription?.cancel();
  }
}
