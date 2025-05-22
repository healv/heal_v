import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/dart/optional.dart';

part 'audio_page_effect.dart';
part 'audio_page_event.dart';
part 'audio_page_state.dart';

class AudioPageBloc extends SideEffectBloc<AudioPageEvent, AudioPageState, AudioPageSideEffect> {
  AudioPageBloc() : super(AudioPageState.initial()) {
    on<_Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<AudioPageState> emitter) async {
    emitter(state.copyWith(
      title: Optional.value(event.title),
      description: Optional.value(event.description),
      previewUrl: Optional.value(event.previewUrl),
    ));
  }
}
