import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/stretching/repo/stretching_repo.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';

part 'stretching_video_page_effect.dart';
part 'stretching_video_page_event.dart';
part 'stretching_video_page_state.dart';

class StretchingVideoPageBloc extends SideEffectBloc<StretchingVideoPageEvent, StretchingVideoPageState, StretchingVideoPageEffect> {
  final StretchingRepo repo;

  StretchingVideoPageBloc(this.repo) : super(StretchingVideoPageState.initial()) {
    on<_Initial>(_handleInitialEvent);
    on<_LessonFinished>(_handLessonFinishedEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<StretchingVideoPageState> emitter) async {
    emitter(state.copyWith(stretchingLesson: Optional.value(event.stretchingLesson), weekId: Optional.value(event.weekId)));
  }

  Future<void> _handLessonFinishedEvent(_LessonFinished event, Emitter<StretchingVideoPageState> emitter) async {
    if (state.stretchingLesson?.isCompleted != true) {
      await for (final response in repo.completeStretchingLesson(state.weekId ?? emptyString, state.stretchingLesson?.id ?? emptyString)) {
        switch (response.status) {
          case ResourceStatusEnum.success:
            addSideEffect(StretchingVideoPageEffect.lessonCompleted());
            await for (final response in repo.getStretchingLesson(state.weekId ?? emptyString, state.stretchingLesson?.id ?? emptyString)) {
              switch (response.status) {
                case ResourceStatusEnum.success:
                  emitter(state.copyWith(stretchingLesson: Optional.value(response.data)));
                  break;
                case ResourceStatusEnum.error:
                  break;
                case ResourceStatusEnum.loading:
                  break;
              }
            }
            break;
          case ResourceStatusEnum.error:
            break;
          case ResourceStatusEnum.loading:
            break;
        }
      }
    }
  }
}
