import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';

part 'stretching_video_page_effect.dart';
part 'stretching_video_page_event.dart';
part 'stretching_video_page_state.dart';

class StretchingVideoPageBloc extends SideEffectBloc<StretchingVideoPageEvent, StretchingVideoPageState, StretchingVideoPageEffect> {
  StretchingVideoPageBloc() : super(StretchingVideoPageState.initial()) {
    on<_Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<StretchingVideoPageState> emitter) async {
    emitter(state.copyWith(stretchingLesson: Optional.value(event.stretchingLesson)));
  }
}
