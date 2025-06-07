import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/repo/quiz_repo.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/utils/resource.dart';
import '../../../../common/dart/optional.dart';

part 'quiz_page_effect.dart';
part 'quiz_page_event.dart';
part 'quiz_page_state.dart';

class QuizPageBloc extends SideEffectBloc<QuizPageEvent, QuizPageState, QuizPageSideEffect> {
  final QuizRepo repo;

  QuizPageBloc(this.repo) : super(QuizPageState.initial()) {
    on<Initial>(_handleInitialEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<QuizPageState> emitter) async {
    await for (final response in repo.getQuiz()) {
      switch (response.status) {
        case ResourceStatusEnum.success:
          emitter(state.copyWith(
            isQuizLoading: false,
            quiz: Optional.value(response.data),
          ));
          break;
        case ResourceStatusEnum.error:
          emitter(state.copyWith(isQuizLoading: false));
          break;
        case ResourceStatusEnum.loading:
          emitter(state.copyWith(isQuizLoading: true));
          break;
      }
    }
  }
}
