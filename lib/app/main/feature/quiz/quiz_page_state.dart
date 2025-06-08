part of 'quiz_page_bloc.dart';

@immutable
class QuizPageState extends BaseState {
  final bool isQuizLoading;
  final QuizDto? quiz;
  final Map<String, String>? answers;
  final int currentQuestionIndex;
  final String? lastQuestionAnswer;
  final String? lastQuestionAnswerErrorMsg;

  const QuizPageState._({
    this.quiz,
    this.answers,
    this.isQuizLoading = false,
    this.currentQuestionIndex = 0,
    this.lastQuestionAnswer,
    this.lastQuestionAnswerErrorMsg,
  });

  factory QuizPageState.initial() => const QuizPageState._();

  @override
  List<Object?> get props => [quiz, answers, isQuizLoading, currentQuestionIndex, lastQuestionAnswer, lastQuestionAnswerErrorMsg];

  QuizPageState copyWith({
    Optional<QuizDto?>? quiz,
    Optional<Map<String, String>?>? answers,
    bool? isQuizLoading,
    int? currentQuestionIndex,
    Optional<String?>? lastQuestionAnswer,
    Optional<String?>? lastQuestionAnswerErrorMsg,
  }) {
    return QuizPageState._(
      quiz: quiz?.isValid == true ? quiz?.value : this.quiz,
      answers: answers?.isValid == true ? answers?.value : this.answers,
      isQuizLoading: isQuizLoading ?? this.isQuizLoading,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      lastQuestionAnswer: lastQuestionAnswer?.isValid == true ? lastQuestionAnswer?.value : this.lastQuestionAnswer,
      lastQuestionAnswerErrorMsg: lastQuestionAnswerErrorMsg?.isValid == true ? lastQuestionAnswerErrorMsg?.value : this.lastQuestionAnswerErrorMsg,
    );
  }
}
