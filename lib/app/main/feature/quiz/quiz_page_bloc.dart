import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/request/complete_quiz_request.dart';
import 'package:heal_v/feature/heal_v/api/quiz/model/response/quiz_dto.dart';
import 'package:heal_v/feature/heal_v/api/quiz/repo/quiz_repo.dart';

import '../../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../../common/utils/resource.dart';
import '../../../../common/dart/optional.dart';
import '../../../../common/tools/localization_tools.dart';

part 'quiz_page_effect.dart';
part 'quiz_page_event.dart';
part 'quiz_page_state.dart';

class QuizPageBloc extends SideEffectBloc<QuizPageEvent, QuizPageState, QuizPageSideEffect> {
  final QuizRepo repo;

  QuizPageBloc(this.repo) : super(QuizPageState.initial()) {
    on<_Initial>(_handleInitialEvent);
    on<_AnswerSelected>(_handleAnswerSelectedEvent);
    on<_LastQuestionAnswerChanged>(_handleLastQuestionAnswerChangedEvent);
    on<_Validate>(_handleValidateEvent);
  }

  Future<void> _handleInitialEvent(_Initial event, Emitter<QuizPageState> emitter) async {
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

  Future<void> _handleAnswerSelectedEvent(_AnswerSelected event, Emitter<QuizPageState> emitter) async {
    final answers = <String, String>{...?state.answers};
    answers[event.questionId] = event.answerId;
    emitter(state.copyWith(answers: Optional.value(answers)));
  }

  Future<void> _handleLastQuestionAnswerChangedEvent(_LastQuestionAnswerChanged event, Emitter<QuizPageState> emitter) async {
    emitter(state.copyWith(lastQuestionAnswer: Optional.value(event.answer)));
  }

  Future<void> _handleValidateEvent(_Validate event, Emitter<QuizPageState> emitter) async {
    if (state.lastQuestionAnswer?.isNotEmpty == true) {
      emitter(state.copyWith(lastQuestionAnswerErrorMsg: const Optional.value(null)));
      await for (final response in repo.completeQuiz(CompleteQuizRequest(answers: state.answers))) {
        switch (response.status) {
          case ResourceStatusEnum.success:
            addSideEffect(QuizPageSideEffect.quizCompleted(ResourceStatusEnum.success));
            break;
          case ResourceStatusEnum.error:
            addSideEffect(QuizPageSideEffect.quizCompleted(ResourceStatusEnum.error));
            break;
          case ResourceStatusEnum.loading:
            addSideEffect(QuizPageSideEffect.quizCompleted(ResourceStatusEnum.loading));
            break;
        }
      }
    } else {
      emitter(state.copyWith(lastQuestionAnswerErrorMsg: Optional.value(tr('this_field_is_required'))));
    }
  }
}
