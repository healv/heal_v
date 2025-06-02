import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/side_effect/side_effect_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/resource.dart';

import '../../../../../../common/bloc/base_event.dart';
import '../../../../../../common/bloc/base_state.dart';
import '../../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../../common/dart/optional.dart';
import '../../../../../../common/tools/localization_tools.dart';

part 'put_journal_effect.dart';
part 'put_journal_event.dart';
part 'put_journal_state.dart';

class PutJournalBloc extends SideEffectBloc<PutJournalEvent, PutJournalState, PutJournalEffect> {
  PutJournalBloc() : super(PutJournalState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<MessageChanged>(_handleMessageChangedEvent);
    on<PutJournal>(_handlePutJournalEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<PutJournalState> emitter) async {}

  Future<void> _handleMessageChangedEvent(MessageChanged event, Emitter<PutJournalState> emitter) async {
    if (event.message.isNotEmpty == true) {
      emitter(state.copyWith(message: Optional.value(event.message), messageErrorMsg: const Optional.value(null)));
    } else {
      emitter(state.copyWith(messageErrorMsg: Optional.value(tr('this_field_is_required')), message: const Optional.value(emptyString)));
    }
  }

  Future<void> _handlePutJournalEvent(PutJournal event, Emitter<PutJournalState> emitter) async {
    if (event.message.isNotEmpty == true) {
      addSideEffect(PutJournalEffect.validated(ResourceStatusEnum.success, message: event.message));
    } else {
      emitter(state.copyWith(messageErrorMsg: Optional.value(tr('this_field_is_required'))));
    }
  }
}
