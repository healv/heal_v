part of 'quiz_page_bloc.dart';

abstract class QuizPageEvent extends BaseEvent {
  const QuizPageEvent();

  factory QuizPageEvent.initial() => const Initial._();
}

final class Initial extends QuizPageEvent {
  const Initial._();
}
