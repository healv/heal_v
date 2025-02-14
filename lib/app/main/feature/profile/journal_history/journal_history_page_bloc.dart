import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'journal_history_page_event.dart';

part 'journal_history_page_state.dart';

class JournalHistoryPageBloc extends Bloc<JournalHistoryPageEvent, JournalHistoryPageState> {
  JournalHistoryPageBloc() : super(JournalHistoryPageInitial()) {
    on<JournalHistoryPageEvent>((event, emit) {});
  }
}
