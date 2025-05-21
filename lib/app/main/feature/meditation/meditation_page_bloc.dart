import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/feature/heal_v/api/meditation/repo/meditations_repo.dart';

part 'meditation_page_event.dart';
part 'meditation_page_state.dart';

class MeditationPageBloc extends BaseBloc<MeditationPageEvent, MeditationPageState> {
  final MeditationsRepo repo;

  MeditationPageBloc(this.repo) : super(MeditationPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<GetMeditations>(_handleGetMeditationsEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<MeditationPageState> emitter) async {
    add(MeditationPageEvent.meditations());
  }

  Future<void> _handleGetMeditationsEvent(GetMeditations event, Emitter<MeditationPageState> emitter) async {
    await for (final response in repo.getMeditationWeeks()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          // final list = response.data?.meditationBreathing ?? [];
          // final map = groupBy(list, (MeditationBreathing item) => item.category ?? emptyString);

          emitter(state.copyWith(
            loading: const Optional.value(false),
            // items: Optional.value(response.data),
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
