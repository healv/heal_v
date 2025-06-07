part of 'quiz_page_bloc.dart';

@immutable
class QuizPageState extends BaseState {
  final bool isQuizLoading;
  final QuizDto? quiz;
  final Map<String, String>? answers;
  final int currentQuestionIndex;

  const QuizPageState._({
    this.quiz,
    this.answers,
    this.isQuizLoading = false,
    this.currentQuestionIndex = 0,
  });

  factory QuizPageState.initial() => const QuizPageState._();

  @override
  List<Object?> get props => [quiz, answers, isQuizLoading];

  QuizPageState copyWith({
    Optional<QuizDto?>? quiz,
    Optional<Map<String, String>?>? answers,
    bool? isQuizLoading,
    int? currentQuestionIndex,
  }) {
    return QuizPageState._(
      quiz: quiz?.isValid == true ? quiz?.value : this.quiz,
      answers: answers?.isValid == true ? answers?.value : this.answers,
      isQuizLoading: isQuizLoading ?? this.isQuizLoading,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    );
  }
}
