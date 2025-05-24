import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/lesson_type_enum.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/dart/optional.dart';
import '../../../../../feature/heal_v/api/meditation/repo/meditations_repo.dart';

part 'audio_page_effect.dart';
part 'audio_page_event.dart';
part 'audio_page_state.dart';

class AudioPageBloc extends SideEffectBloc<AudioPageEvent, AudioPageState, AudioPageSideEffect> {
  final MeditationsRepo? meditationsRepo;
  final BreathingsRepo? breathingsRepo;

  AudioPageBloc({this.meditationsRepo, this.breathingsRepo}) : super(AudioPageState.initial()) {
    on<_Initial>(_handleInitialEvent);
    on<_LessonCompleted>(_handleLessonCompletedEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<AudioPageState> emitter) async {
    emitter(state.copyWith(
      lessonTypeEnum: Optional.value(event.lessonTypeEnum),
      id: Optional.value(event.id),
      weekId: Optional.value(event.weekId),
      title: Optional.value(event.title),
      description: Optional.value(event.description),
      previewUrl: Optional.value(event.previewUrl),
      isCompleted: Optional.value(event.isCompleted),
    ));
  }

  Future<void> _handleLessonCompletedEvent(_LessonCompleted event, Emitter<AudioPageState> emitter) async {
    if (state.isCompleted != true) {
      switch (state.lessonTypeEnum) {
        case LessonTypeEnum.meditation:
          await for (final response in meditationsRepo!.completeMeditationLesson(
            weekId: state.weekId ?? emptyString,
            lessonId: state.id ?? emptyString,
          )) {
            switch (response.status) {
              case ResourceStatusEnum.success:
                emitter(state.copyWith(isCompleted: const Optional.value(true)));
                addSideEffect(AudioPageSideEffect.lessonCompleted(loopMode: event.loopMode));
              default:
                break;
            }
          }
          break;
        case LessonTypeEnum.breathing:
          await for (final response in breathingsRepo!.completeBreathingLesson(
            weekId: state.weekId ?? emptyString,
            lessonId: state.id ?? emptyString,
          )) {
            switch (response.status) {
              case ResourceStatusEnum.success:
                emitter(state.copyWith(isCompleted: const Optional.value(true)));
                addSideEffect(AudioPageSideEffect.lessonCompleted(loopMode: event.loopMode));
              default:
                break;
            }
          }
          break;
        case null:
          break;
      }
    }
  }
}
