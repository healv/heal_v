import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect.dart';

import '../base_bloc.dart';
import '../base_event.dart';
import '../base_state.dart';

abstract class SideEffectBloc<Event extends BaseEvent, State extends BaseState, Effect extends SideEffect> extends BaseBloc<Event, State> {
  SideEffectBloc(super.initialState);

  final _sideEffectsController = StreamController<Effect>.broadcast();

  Stream<Effect> get sideEffects => _sideEffectsController.stream;

  @nonVirtual
  void addSideEffect(Effect effect) {
    _sideEffectsController.add(effect);
  }

  @mustCallSuper
  @override
  Future<void> close() {
    _sideEffectsController.close();
    return super.close();
  }
}
