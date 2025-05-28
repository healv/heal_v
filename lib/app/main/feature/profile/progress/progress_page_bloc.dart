import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_state.dart';

import '../../../../../common/dart/optional.dart';

part 'progress_page_event.dart';
part 'progress_page_state.dart';

class ProgressPageBloc extends Bloc<ProgressPageEvent, ProgressPageState> {
  ProgressPageBloc() : super(ProgressPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<PreviousMonth>(_handlePreviousMonthEvent);
    on<NextMonth>(_handleNextMonthEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ProgressPageState> emitter) async {
    emitter(state.copyWith(currentMonth: Optional.value(DateTime.now())));
  }

  Future<void> _handlePreviousMonthEvent(PreviousMonth event, Emitter<ProgressPageState> emitter) async {
    if (state.currentMonth != null && state.currentMonth != DateTime(2025, 1)) {
      emitter(state.copyWith(currentMonth: Optional.value(DateTime(state.currentMonth!.year, state.currentMonth!.month - 1))));
    }
  }

  Future<void> _handleNextMonthEvent(NextMonth event, Emitter<ProgressPageState> emitter) async {
    if (state.currentMonth != null && state.currentMonth!.month != DateTime.now().month) {
      emitter(state.copyWith(currentMonth: Optional.value(DateTime(state.currentMonth!.year, state.currentMonth!.month + 1))));
    }
  }
}
