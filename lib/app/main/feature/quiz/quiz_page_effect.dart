part of 'quiz_page_bloc.dart';

sealed class QuizPageSideEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const QuizPageSideEffect(this.status, {this.errorMsg});

  factory QuizPageSideEffect.quizCompleted(ResourceStatusEnum status, {String? errorMsg}) => QuizCompleted._(status, errorMsg: errorMsg);
}

final class QuizCompleted extends QuizPageSideEffect {
  const QuizCompleted._(super.status, {super.errorMsg});
}
