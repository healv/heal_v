import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/dart/optional.dart';
import '../../common/model/meditation_breathing_ui_model.dart';

part 'meditation_breathing_audio_page_effect.dart';
part 'meditation_breathing_audio_page_event.dart';
part 'meditation_breathing_audio_page_state.dart';

class MeditationBreathingAudioPageBloc extends SideEffectBloc<MeditationBreathingAudioPageEvent, MeditationBreathingAudioPageState, MeditationBreathingAudioPageSideEffect> {
  MeditationBreathingAudioPageBloc() : super(MeditationBreathingAudioPageState.initial()) {
    on<_Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<MeditationBreathingAudioPageState> emitter) async {
    emitter(state.copyWith(item: Optional.value(event.item)));
  }
}
