import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/breathing/model/breathing_lessons.dart';
import 'package:heal_v/app/main/feature/breathing/model/breathing_week.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/breathing/repo/breathing_repo.dart';

import '../../../../common/utils/constants.dart';

part 'breathing_page_event.dart';
part 'breathing_page_state.dart';

class BreathingPageBloc extends BaseBloc<BreathingPageEvent, BreathingPageState> {
  final BreathingsRepo repo;

  BreathingPageBloc(this.repo) : super(BreathingPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetBreathingWeeks>(_handleGetBreathingWeeksEvent);
    on<GetBreathingLessons>(_handleGetBreathingLessonsEvent);
    on<ChangeSelectedWeek>(_handleChangeSelectedWeekEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<BreathingPageState> emitter) async {
    add(BreathingPageEvent.getBreathingWeeks());
  }

  Future<void> _handleGetBreathingWeeksEvent(GetBreathingWeeks event, Emitter<BreathingPageState> emitter) async {
    await for (final response in repo.getBreathingWeeks()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            weeksLoading: const Optional.value(false),
            weeks: Optional.value(response.data),
          ));
          if (response.data?.isNotEmpty == true) {
            add(BreathingPageEvent.changeSelectedWeek(id: response.data?.first.id ?? emptyString));
          }
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(weeksLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(weeksLoading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleGetBreathingLessonsEvent(GetBreathingLessons event, Emitter<BreathingPageState> emitter) async {
    await for (final response in repo.getBreathingLessons(weekId: event.id)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            lessonsLoading: const Optional.value(false),
            breathingLessons: Optional.value(response.data),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(lessonsLoading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(lessonsLoading: const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleChangeSelectedWeekEvent(ChangeSelectedWeek event, Emitter<BreathingPageState> emitter) async {
    emitter(state.copyWith(selectedWeekId: Optional.value(event.id)));
    add(BreathingPageEvent.getBreathingLessons(id: event.id));
  }
}
