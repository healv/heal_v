part of 'quiz_page_bloc.dart';

abstract class QuizPageEvent extends BaseEvent {
  const QuizPageEvent();

  factory QuizPageEvent.initial() => const _Initial._();

  factory QuizPageEvent.answerSelected({
    required String questionId,
    required String answerId,
  }) =>
      _AnswerSelected._(questionId: questionId, answerId: answerId);

  factory QuizPageEvent.lastQuestionAnswerChanged({required String answer}) => _LastQuestionAnswerChanged._(answer: answer);

  factory QuizPageEvent.validate() => const _Validate._();
}

final class _Initial extends QuizPageEvent {
  const _Initial._();
}

final class _AnswerSelected extends QuizPageEvent {
  final String questionId;
  final String answerId;

  const _AnswerSelected._({required this.questionId, required this.answerId});
}

final class _LastQuestionAnswerChanged extends QuizPageEvent {
  final String answer;

  const _LastQuestionAnswerChanged._({required this.answer});
}

final class _Validate extends QuizPageEvent {
  const _Validate._();
}
