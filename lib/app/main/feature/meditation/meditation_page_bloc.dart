import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/meditation/model/meditation_lessons.dart';
import 'package:heal_v/app/main/feature/meditation/model/meditation_week.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo.dart';

import '../../../../common/utils/constants.dart';

part 'meditation_page_event.dart';
part 'meditation_page_state.dart';

class MeditationPageBloc extends BaseBloc<MeditationPageEvent, MeditationPageState> {
  final MeditationsRepo repo;

  MeditationPageBloc(this.repo) : super(MeditationPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetMeditationWeeks>(_handleGetMeditationWeeksEvent);
    on<GetMeditationLessons>(_handleGetMeditationLessonsEvent);
    on<ChangeSelectedWeek>(_handleChangeSelectedWeekEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<MeditationPageState> emitter) async {
    add(MeditationPageEvent.getMeditationWeeks());
  }

  Future<void> _handleGetMeditationWeeksEvent(GetMeditationWeeks event, Emitter<MeditationPageState> emitter) async {
    await for (final response in repo.getMeditationWeeks()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            weeksLoading: event.isLoading == true ? const Optional.value(false) : null,
            weeks: Optional.value(response.data),
          ));
          if (response.data?.isNotEmpty == true) {
            add(MeditationPageEvent.changeSelectedWeek(id: state.selectedWeekId ?? response.data?.first.id ?? emptyString, isLoading: event.isLoading));
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

  Future<void> _handleGetMeditationLessonsEvent(GetMeditationLessons event, Emitter<MeditationPageState> emitter) async {
    await for (final response in repo.getMeditationLessons(weekId: event.id)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            lessonsLoading: event.isLoading == true ? const Optional.value(false) : null,
            meditationLessons: Optional.value(response.data),
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

  Future<void> _handleChangeSelectedWeekEvent(ChangeSelectedWeek event, Emitter<MeditationPageState> emitter) async {
    emitter(state.copyWith(selectedWeekId: Optional.value(event.id)));
    add(MeditationPageEvent.getMeditationLessons(id: event.id, isLoading: event.isLoading));
  }
}
