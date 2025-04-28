import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_week_ui_model.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/stretching/repo/stretching_repo.dart';

import '../../../../common/bloc/base_bloc.dart';
import '../../../../common/bloc/base_event.dart';
import '../../../../common/bloc/base_state.dart';
import '../../../../common/dart/optional.dart';
import '../../../../common/utils/resource.dart';
import 'model/stretching_lessons_ui_model.dart';

part 'stretching_page_event.dart';
part 'stretching_page_state.dart';

class StretchingPageBloc extends BaseBloc<StretchingPageEvent, StretchingPageState> {
  final StretchingRepo repo;

  StretchingPageBloc(this.repo) : super(StretchingPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetStretchingWeeks>(_handleGetStretchingWeeksEvent);
    on<GetStretchingLessons>(_handleGetStretchingLessonsEvent);
    on<ChangeSelectedWeek>(_handleChangeSelectedWeekEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<StretchingPageState> emitter) async {
    add(StretchingPageEvent.getStretchingWeeks());
  }

  Future<void> _handleGetStretchingWeeksEvent(GetStretchingWeeks event, Emitter<StretchingPageState> emitter) async {
    await for (final response in repo.getStretchingWeeks()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(
            state.copyWith(
              weeksLoading: const Optional.value(false),
              weeks: Optional.value(response.data),
            ),
          );
          add(StretchingPageEvent.changeSelectedWeek(id: response.data?.first.id ?? emptyString));
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

  Future<void> _handleGetStretchingLessonsEvent(GetStretchingLessons event, Emitter<StretchingPageState> emitter) async {
    await for (final response in repo.getStretchingLessons(event.id)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            lessonsLoading: const Optional.value(false),
            stretchingLessons: Optional.value(response.data),
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

  Future<void> _handleChangeSelectedWeekEvent(ChangeSelectedWeek event, Emitter<StretchingPageState> emitter) async {
    emitter(state.copyWith(selectedWeekId: Optional.value(event.id)));
    add(StretchingPageEvent.getStretchingLessons(id: event.id));
  }
}
