import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/daily_progress_repo.dart';

import '../../../common/bloc/base_event.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends BaseBloc<ProgressEvent, ProgressState> {
  final DailyProgressRepo repo;

  ProgressBloc(this.repo) : super(ProgressState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ProgressState> emitter) async {
    await for (final response in repo.getDailyProgress()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            meditation: Optional.value(response.data?.meditation),
            breathing: Optional.value(response.data?.breathing),
            stretching: Optional.value(response.data?.stretching),
            journal: Optional.value(response.data?.journal),
            completed: Optional.value(response.data?.completed),
            loading: const Optional.value(false),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }
}
