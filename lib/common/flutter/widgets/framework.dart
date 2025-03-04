import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/side_effect/side_effect.dart';
import '../../bloc/side_effect/side_effect_bloc.dart';

@optionalTypeArgs
abstract class BlocDependentSideEffectState<T extends StatefulWidget, Bloc extends SideEffectBloc<dynamic, dynamic, Effect>, Effect extends SideEffect> extends State<T> {
  StreamSubscription<Effect>? _subscription;

  @mustCallSuper
  @override
  void initState() {
    _subscription = context.read<Bloc>().sideEffects.listen(handleSideEffect);
    super.initState();
  }

  Future<void> handleSideEffect(Effect effect);

  @mustCallSuper
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
