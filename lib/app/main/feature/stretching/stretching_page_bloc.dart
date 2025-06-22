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
    add(StretchingPageEvent.getStretchingWeeks(isLoading: true));
  }

  Future<void> _handleGetStretchingWeeksEvent(GetStretchingWeeks event, Emitter<StretchingPageState> emitter) async {
    await for (final response in repo.getStretchingWeeks()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(
            state.copyWith(
              weeksLoading: event.isLoading == true ? const Optional.value(false) : null,
              weeks: Optional.value(response.data),
            ),
          );
          if (response.data?.isNotEmpty == true) {
            add(StretchingPageEvent.changeSelectedWeek(id: response.data?.first.id ?? emptyString, isLoading: event.isLoading));
          }
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(weeksLoading: event.isLoading == true ? const Optional.value(false) : null));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(weeksLoading: event.isLoading == true ? const Optional.value(true) : null));
          break;
      }
    }
  }

  Future<void> _handleGetStretchingLessonsEvent(GetStretchingLessons event, Emitter<StretchingPageState> emitter) async {
    await for (final response in repo.getStretchingLessons(event.id)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            lessonsLoading: event.isLoading == true ? const Optional.value(false) : null,
            stretchingLessons: Optional.value(response.data),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(lessonsLoading: event.isLoading == true ? const Optional.value(false) : null));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(lessonsLoading: event.isLoading == true ? const Optional.value(true) : null));
          break;
      }
    }
  }

  Future<void> _handleChangeSelectedWeekEvent(ChangeSelectedWeek event, Emitter<StretchingPageState> emitter) async {
    emitter(state.copyWith(selectedWeekId: Optional.value(event.id)));
    add(StretchingPageEvent.getStretchingLessons(id: event.id, isLoading: event.isLoading));
  }
}
