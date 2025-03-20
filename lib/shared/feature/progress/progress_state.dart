part of 'progress_bloc.dart';

@immutable
final class ProgressState extends BaseState {
  final bool? meditation;
  final bool? breathing;
  final bool? stretching;
  final bool? journal;
  final bool? completed;
  final String? lastUpdated;
  final bool loading;

  const ProgressState._({
    this.meditation,
    this.breathing,
    this.stretching,
    this.journal,
    this.completed,
    this.lastUpdated,
    this.loading = false,
  });

  factory ProgressState.initial() => const ProgressState._();

  @override
  List<Object?> get props => [loading, meditation, breathing, stretching, journal, completed, lastUpdated];

  ProgressState copyWith({
    Optional<bool?>? meditation,
    Optional<bool?>? breathing,
    Optional<bool?>? stretching,
    Optional<bool?>? journal,
    Optional<bool?>? completed,
    Optional<String?>? lastUpdated,
    Optional<bool?>? loading,
  }) {
    return ProgressState._(
      meditation: meditation?.isValid == true ? meditation?.value : this.meditation,
      breathing: breathing?.isValid == true ? breathing?.value : this.breathing,
      stretching: stretching?.isValid == true ? stretching?.value : this.stretching,
      journal: journal?.isValid == true ? journal?.value : this.journal,
      completed: completed?.isValid == true ? completed?.value : this.completed,
      lastUpdated: lastUpdated?.isValid == true ? lastUpdated?.value : this.lastUpdated,
      loading: loading?.isValid == true ? loading?.value ?? false : this.loading,
    );
  }
}
