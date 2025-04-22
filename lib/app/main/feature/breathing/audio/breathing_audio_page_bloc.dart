import 'package:flutter/material.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/dart/optional.dart';
import '../../common/model/meditation_breathing_ui_model.dart';

part 'breathing_audio_page_effect.dart';
part 'breathing_audio_page_event.dart';
part 'breathing_audio_page_state.dart';

class BreathingAudioPageBloc extends SideEffectBloc<BreathingAudioPageEvent, BreathingPageState, BreathingAudioPageSideEffect> {
  BreathingAudioPageBloc() : super(BreathingPageState.initial()) {

  }
}
