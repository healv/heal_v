import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';

part 'launch_page_bloc_event.dart';

part 'launch_page_bloc_state.dart';

class LaunchPageBloc extends BaseBloc<LaunchPageBlocEvent, LaunchPageBlocState> {
  LaunchPageBloc() : super(LaunchPageBlocState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<LaunchPageBlocState> emitter) async {}
}
