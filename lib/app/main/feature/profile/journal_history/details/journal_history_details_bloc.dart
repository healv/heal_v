import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/request/daily_progress_request.dart';

import '../../../../../../common/bloc/base_event.dart';
import '../../../../../../common/bloc/base_state.dart';
import '../../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../../common/dart/optional.dart';
import '../../../../../../feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import '../../../../../../feature/heal_v/api/progress/repo/progress_repo.dart';

part 'journal_history_details_effect.dart';
part 'journal_history_details_event.dart';
part 'journal_history_details_state.dart';

class JournalHistoryDetailsBloc extends SideEffectBloc<JournalHistoryDetailsEvent, JournalHistoryDetailsState, JournalHistoryDetailsEffect> {
  final ProgressRepo repo;

  JournalHistoryDetailsBloc(this.repo) : super(JournalHistoryDetailsState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<DeleteJournal>(_handleDeleteJournalEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<JournalHistoryDetailsState> emitter) async {
    emitter(state.copyWith(progressItem: Optional.value(event.progressItem)));
  }

  Future<void> _handleDeleteJournalEvent(DeleteJournal event, Emitter<JournalHistoryDetailsState> emitter) async {
    await for (final response in repo.updateDailyProgress(
      date: event.date,
      dailyProgressRequest: DailyProgressRequest(journal: emptyString),
    )) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(loading: const Optional.value(false)));
          addSideEffect(JournalHistoryDetailsEffect.journalDeleted(ResourceStatusEnum.success, date: event.date));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(loading: const Optional.value(false)));
          addSideEffect(JournalHistoryDetailsEffect.journalDeleted(ResourceStatusEnum.error));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: const Optional.value(true)));
          break;
      }
    }
  }
}
