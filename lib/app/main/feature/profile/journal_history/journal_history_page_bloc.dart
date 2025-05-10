import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/extensions/date_time_extension.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/journal/model/journal_history_dto.dart';
import 'package:heal_v/feature/heal_v/api/journal/repo/journal_repo.dart';

import '../../../../../common/bloc/base_event.dart';
import '../../../../../common/bloc/base_state.dart';
import '../../../../../common/dart/optional.dart';
import '../../../../../common/utils/resource.dart';

part 'journal_history_page_event.dart';
part 'journal_history_page_state.dart';

class JournalHistoryPageBloc extends BaseBloc<JournalHistoryPageEvent, JournalHistoryPageState> {
  final JournalRepo repo;

  JournalHistoryPageBloc(this.repo) : super(JournalHistoryPageState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<JournalHistoryPageState> emitter) async {
    await for (final response in repo.getJournalHistory()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          final history = response.data?.isNotEmpty == true
              ? response.data!
              : [
                  JournalHistoryDto(message: 'Advantages of yoga', date: '15/05/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '14/05/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '13/06/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '14/06/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '10/07/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '15/07/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '15/08/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '15/08/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '15/08/2024'),
                  JournalHistoryDto(message: 'Advantages of yoga', date: '15/09/2024'), //todo remove test data
                ];

          final Map<String, List<JournalHistoryDto>> grouped = {};
          for (var item in history) {
            final key = DateFormat('dd/MM/yyyy').parse(item.date ?? emptyString).mmmmYYYY();
            grouped.putIfAbsent(key, () => []).add(item);
          }
          emitter(state.copyWith(
            loading: const Optional.value(false),
            journalHistory: Optional.value(response.data),
            grouped: Optional.value(grouped),
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
