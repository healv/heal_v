import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/progress/model/response/daily_progress_dto.dart';
import 'package:heal_v/feature/heal_v/api/progress/repo/progress_repo.dart';

import '../../../../../common/bloc/base_event.dart';
import '../../../../../common/bloc/base_state.dart';
import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/dart/optional.dart';
import '../../../../../common/utils/resource.dart';

part 'journal_history_page_effect.dart';
part 'journal_history_page_event.dart';
part 'journal_history_page_state.dart';

class JournalHistoryPageBloc extends SideEffectBloc<JournalHistoryPageEvent, JournalHistoryPageState, JournalHistoryPageEffect> {
  final ProgressRepo repo;

  JournalHistoryPageBloc(this.repo) : super(JournalHistoryPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetJournalHistory>(_handleGetJournalHistoryEvent);
    on<DeleteJournal>(_handleDeleteJournalEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<JournalHistoryPageState> emitter) async {
    await for (final response in repo.getDailyProgressList(page: 1, pageSize: 20)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          final history = response.data?.data?.where((item) => item.journal?.isNotEmpty == true).toList() ?? [];

          final Map<String, List<DailyProgressDto>> grouped = {};
          for (var item in history) {
            final key = DateFormat('yyyy-MM-dd').parse(item.date ?? emptyString).mmmmYYYY();
            grouped.putIfAbsent(key, () => []).add(item);
          }
          emitter(state.copyWith(
              loading: const Optional.value(false),
              journalHistory: Optional.value([...?state.journalHistory, ...?response.data?.data]),
              grouped: Optional.value(grouped),
              pageNumber: Optional.value(response.data?.pagination?.page ?? 1)));
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

  Future<void> _handleGetJournalHistoryEvent(GetJournalHistory event, Emitter<JournalHistoryPageState> emitter) async {
    await for (final response in repo.getDailyProgressList(page: event.page ?? (state.pageNumber ?? 0) + 1, pageSize: 20)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          final history = response.data?.data?.where((item) => item.journal?.isNotEmpty == true).toList() ?? [];

          final Map<String, List<DailyProgressDto>> grouped = {};
          for (var item in history) {
            final key = DateFormat('yyyy-MM-dd').parse(item.date ?? emptyString).mmmmYYYY();
            grouped.putIfAbsent(key, () => []).add(item);
          }
          final Map<String, List<DailyProgressDto>> finalGroup = state.grouped ?? {};
          for (var entry in grouped.entries) {
            if (finalGroup[entry.key] != null) {
              finalGroup[entry.key]?.addAll(entry.value);
            } else {
              finalGroup[entry.key] = entry.value;
            }
          }
          emitter(
            state.copyWith(
              loading: const Optional.value(false),
              journalHistory: Optional.value([...?state.journalHistory, ...?response.data?.data]),
              grouped: Optional.value(finalGroup),
              pageNumber: Optional.value(response.data?.pagination?.page ?? 1),
              isLastPage: Optional.value((response.data?.data?.length ?? 0) < 10),
            ),
          );
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(loading: const Optional.value(false)));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(loading: state.journalHistory?.isNotEmpty == true ? null : const Optional.value(true)));
          break;
      }
    }
  }

  Future<void> _handleDeleteJournalEvent(DeleteJournal event, Emitter<JournalHistoryPageState> emitter) async {
    if (event.date == null) {
      return;
    }
    final items = [...?state.journalHistory];
    final groupedItems = {...?state.grouped};
    final key = DateFormat('yyyy-MM-dd').parse(event.date ?? emptyString).mmmmYYYY();
    items.removeWhere((item) => item.date == event.date);
    final groupedItemsFilteredValue = groupedItems[key]?.where((item) => item.date != event.date).toList();
    if (groupedItemsFilteredValue?.isNotEmpty == true) {
      groupedItems[key] = groupedItems[key]?.where((item) => item.date != event.date).toList() ?? [];
    } else {
      groupedItems.remove(key);
    }

    emitter(
      state.copyWith(
        journalHistory: Optional.value(items),
        grouped: Optional.value(groupedItems),
      ),
    );
  }
}
