import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/feature/heal_v/api/stretching/repo/stretching_repo.dart';

import '../../../../../common/bloc/base_bloc.dart';
import '../../../../../common/bloc/base_event.dart';
import '../../../../../common/bloc/base_state.dart';
import '../../../../../common/dart/optional.dart';
import '../../../../../common/utils/resource.dart';
import '../model/stretching_lessons_ui_model.dart';

part 'stretching_details_page_event.dart';
part 'stretching_details_page_state.dart';

class StretchingDetailsPageBloc extends BaseBloc<StretchingDetailsPageEvent, StretchingDetailsPageState> {
  final StretchingRepo repo;

  StretchingDetailsPageBloc(this.repo) : super(StretchingDetailsPageState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<StretchingDetailsPageState> emitter) async {
    emitter(state.copyWith(weekTitle: Optional.value(event.weekTitle), weekId: Optional.value(event.weekId)));
    await for (final response in repo.getStretchingLesson(event.weekId, event.lessonId)) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(stretchingLesson: Optional.value(response.data)));
          break;
        case ResourceStatusEnum.error:
          break;
        case ResourceStatusEnum.loading:
          break;
      }
    }
  }
}
