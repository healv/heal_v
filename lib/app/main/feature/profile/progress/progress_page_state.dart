part of 'progress_page_bloc.dart';

@immutable
final class ProgressPageState extends BaseState {
  final DateTime? currentMonth;

  const ProgressPageState._({
    this.currentMonth,
  });

  factory ProgressPageState.initial() => const ProgressPageState._();

  @override
  List<Object?> get props => [currentMonth];

  ProgressPageState copyWith({
    Optional<DateTime?>? currentMonth,
  }) {
    return ProgressPageState._(
      currentMonth: currentMonth?.isValid == true ? currentMonth?.value : this.currentMonth,
    );
  }
}
