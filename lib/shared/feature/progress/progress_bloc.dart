import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/progress_repo.dart';

import '../../../common/bloc/base_event.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends BaseBloc<ProgressEvent, ProgressState> {
  final ProgressRepo repo;

  ProgressBloc(this.repo) : super(ProgressState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetDailyProgress>(_handleGetDailyProgressEvent);
    on<GetTreeGrowth>(_handleGetTreeGrowthEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ProgressState> emitter) async {
    add(ProgressEvent.getDailyProgress());
    add(ProgressEvent.getTreeGrowth());
  }

  Future<void> _handleGetDailyProgressEvent(GetDailyProgress event, Emitter<ProgressState> emitter) async {
    await for (final response in repo.getDailyProgress(date: event.date)) {
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

  Future<void> _handleGetTreeGrowthEvent(GetTreeGrowth event, Emitter<ProgressState> emitter) async {
    await for (final response in repo.getTreeGrowth()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            treeGrowth: Optional.value(response.data),
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
