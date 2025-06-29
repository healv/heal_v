import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';

import '../../common/bloc/side_effect/side_effect.dart';
import '../../common/tools/store.dart';
import '../../common/utils/store_key.dart';

part 'launch_page_bloc_effect.dart';
part 'launch_page_bloc_event.dart';
part 'launch_page_bloc_state.dart';

class LaunchPageBloc extends SideEffectBloc<LaunchPageBlocEvent, LaunchPageBlocState, LaunchPageSideEffect> {
  LaunchPageBloc() : super(LaunchPageBlocState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<LaunchPageBlocState> emitter) async {
    if (await Store.get<bool>(key: StoreKey.isNotFirstRun, defaultValue: false) == false) {
      addSideEffect(LaunchPageSideEffect.navigateToOnboarding());
    }
  }
}
