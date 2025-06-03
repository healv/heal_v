import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/total_progress_dto.dart';

import '../../../../../common/dart/optional.dart';
import '../../../../../feature/heal_v/api/progress/model/response/daily_progress_list_dto.dart';
import '../../../../../feature/heal_v/api/progress/repo/progress_repo.dart';

part 'progress_page_event.dart';
part 'progress_page_state.dart';

class ProgressPageBloc extends Bloc<ProgressPageEvent, ProgressPageState> {
  final ProgressRepo repo;

  ProgressPageBloc(this.repo) : super(ProgressPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<TotalProgress>(_handleTotalProgressEvent);
    on<DailyProgressList>(_handleDailyProgressListEvent);
    on<PreviousMonth>(_handlePreviousMonthEvent);
    on<NextMonth>(_handleNextMonthEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<ProgressPageState> emitter) async {
    emitter(state.copyWith(currentMonth: Optional.value(DateTime.now())));
    add(
      ProgressPageEvent.dailyProgressList(
        startDate: DateFormat('yyyy-MM-dd').format(
          DateTime(DateTime.now().year, DateTime.now().month, 1),
        ),
        endDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      ),
    );
    add(ProgressPageEvent.totalProgress());
  }

  Future<void> _handleTotalProgressEvent(TotalProgress event, Emitter<ProgressPageState> emitter) async {
    await for (final response in repo.totalProgress()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(
            state.copyWith(
              totalProgressLoading: const Optional.value(false),
              totalProgress: Optional.value(response.data),
            ),
          );
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(totalProgressLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(totalProgressLoading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleDailyProgressListEvent(DailyProgressList event, Emitter<ProgressPageState> emitter) async {
    await for (final response in repo.getDailyProgressList(startDate: event.startDate, endDate: event.endDate)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(
            state.copyWith(
              progressListLoading: const Optional.value(false),
              progressList: Optional.value(response.data),
            ),
          );
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(progressListLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(progressListLoading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handlePreviousMonthEvent(PreviousMonth event, Emitter<ProgressPageState> emitter) async {
    if (state.currentMonth != null && state.currentMonth != DateTime(2025, 1)) {
      emitter(state.copyWith(currentMonth: Optional.value(DateTime(state.currentMonth!.year, state.currentMonth!.month - 1))));
      add(
        ProgressPageEvent.dailyProgressList(
          startDate: DateFormat('yyyy-MM-dd').format(
            DateTime(state.currentMonth!.year, state.currentMonth!.month, 1),
          ),
          endDate: DateFormat('yyyy-MM-dd').format(
            DateTime(state.currentMonth!.year, state.currentMonth!.month + 1, 0),
          ),
        ),
      );
    }
  }

  Future<void> _handleNextMonthEvent(NextMonth event, Emitter<ProgressPageState> emitter) async {
    if (state.currentMonth != null && state.currentMonth!.month != DateTime.now().month) {
      emitter(state.copyWith(currentMonth: Optional.value(DateTime(state.currentMonth!.year, state.currentMonth!.month + 1))));
      add(
        ProgressPageEvent.dailyProgressList(
          startDate: DateFormat('yyyy-MM-dd').format(
            DateTime(state.currentMonth!.year, state.currentMonth!.month, 1),
          ),
          endDate: DateFormat('yyyy-MM-dd').format(
            DateTime(state.currentMonth!.year, state.currentMonth!.month + 1, 0),
          ),
        ),
      );
    }
  }
}
