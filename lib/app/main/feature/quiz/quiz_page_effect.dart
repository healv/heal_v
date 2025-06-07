part of 'quiz_page_bloc.dart';

sealed class QuizPageSideEffect implements SideEffect {
  final ResourceStatusEnum status;
  final String? errorMsg;

  const QuizPageSideEffect(this.status, {this.errorMsg});
}
