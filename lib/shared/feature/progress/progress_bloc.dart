import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/request/daily_progress_request.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/tree_growth_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/progress_repo.dart';
import 'package:heal_v/shared/feature/progress/progress_effect.dart';

import '../../../common/bloc/base_event.dart';
import '../../../feature/heal_v/api/progress/model/response/daily_progress_dto.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends SideEffectBloc<ProgressEvent, ProgressState, ProgressEffect> {
  final ProgressRepo repo;

  ProgressBloc(this.repo) : super(ProgressState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetDailyProgress>(_handleGetDailyProgressEvent);
    on<GetTreeGrowth>(_handleGetTreeGrowthEvent);
    on<UpdateDailyProgress>(_handleUpdateDailyProgressEvent);
    on<GetDailyProgressList>(_handleGetDailyProgressListEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ProgressState> emitter) async {
    add(ProgressEvent.getDailyProgress());
    add(ProgressEvent.getTreeGrowth());
  }

  Future<void> _handleGetDailyProgressEvent(GetDailyProgress event, Emitter<ProgressState> emitter) async {
    await for (final response in repo.getDailyProgress(date: event.date)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          final isCompletedBefore =
              state.breathing == true && state.meditation == true && state.stretching == true && state.journal?.isNotEmpty == true;
          final isAllCompleted = response.data?.meditation == true &&
              response.data?.breathing == true &&
              response.data?.stretching == true &&
              response.data?.journal?.isNotEmpty == true;
          emitter(state.copyWith(
            meditation: Optional.value(response.data?.meditation),
            breathing: Optional.value(response.data?.breathing),
            stretching: Optional.value(response.data?.stretching),
            journal: Optional.value(response.data?.journal),
            quiz: Optional.value(response.data?.quiz),
            completed: Optional.value(response.data?.completed),
            loading: const Optional.value(false),
          ));
          if (isAllCompleted == true && isAllCompleted != isCompletedBefore && state.quiz?.completed != true) {
            addSideEffect(ProgressEffect.dailyProgressFinished(ResourceStatusEnum.success));
            emitter(state.copyWith(dailyGoalsCompleted: const Optional.value(true)));
          }
          if (isAllCompleted == true && state.quiz?.completed == true && state.dailyGoalsCompleted != true) {
            emitter(state.copyWith(dailyGoalsCompleted: const Optional.value(true)));
          }
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

  Future<void> _handleUpdateDailyProgressEvent(UpdateDailyProgress event, Emitter<ProgressState> emitter) async {
    await for (final response in repo.updateDailyProgress(date: event.date, dailyProgressRequest: event.dailyProgressRequest)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          final isCompletedBefore =
              state.breathing == true && state.meditation == true && state.stretching == true && state.journal?.isNotEmpty == true;
          final isAllCompleted = response.data?.meditation == true &&
              response.data?.breathing == true &&
              response.data?.stretching == true &&
              response.data?.journal?.isNotEmpty == true;
          if (event.date == null) {
            emitter(state.copyWith(
              meditation: Optional.value(response.data?.meditation),
              breathing: Optional.value(response.data?.breathing),
              stretching: Optional.value(response.data?.stretching),
              journal: Optional.value(response.data?.journal),
              completed: Optional.value(response.data?.completed),
              loading: const Optional.value(false),
            ));
          }
          addSideEffect(ProgressEffect.progressUpdated(ResourceStatusEnum.success, date: event.date, dailyProgressDto: response.data));
          if (event.date == null) {
            add(ProgressEvent.getDailyProgress());
            if (isAllCompleted == true && isAllCompleted != isCompletedBefore && state.quiz?.passed != true) {
              addSideEffect(ProgressEffect.dailyProgressFinished(ResourceStatusEnum.success));
              emitter(state.copyWith(dailyGoalsCompleted: const Optional.value(true)));
            }
          }
          break;
        case ResourceStatusEnum.error:
          addSideEffect(ProgressEffect.progressUpdated(ResourceStatusEnum.error, errorMsg: response.error));
          emitter(state.copyWith(loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          addSideEffect(ProgressEffect.progressUpdated(ResourceStatusEnum.loading));
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleGetDailyProgressListEvent(GetDailyProgressList event, Emitter<ProgressState> emitter) async {
    await for (final response in repo.getDailyProgressList(
      startDate: event.startDate,
      endDate: event.endDate,
      page: event.page,
      pageSize: event.pageSize,
    )) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          addSideEffect(ProgressEffect.dailyProgressListFetched(
            ResourceStatusEnum.success,
            startDate: event.startDate,
            endDate: event.endDate,
            page: event.page,
            pageSize: event.pageSize,
            dailyProgressList: response.data,
          ));
          break;
        case ResourceStatusEnum.error:
          addSideEffect(ProgressEffect.dailyProgressListFetched(ResourceStatusEnum.error, errorMsg: response.error));
          emitter(state.copyWith(loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          addSideEffect(ProgressEffect.dailyProgressListFetched(ResourceStatusEnum.loading));
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }
}
