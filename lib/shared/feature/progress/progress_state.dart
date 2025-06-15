part of 'progress_bloc.dart';

@immutable
final class ProgressState extends BaseState {
  final bool? meditation;
  final bool? breathing;
  final bool? stretching;
  final String? journal;
  final bool? quiz;
  final bool? completed;
  final TreeGrowthDto? treeGrowth;
  final bool loading;

  const ProgressState._({
    this.meditation,
    this.breathing,
    this.stretching,
    this.journal,
    this.quiz,
    this.completed,
    this.treeGrowth,
    this.loading = false,
  });

  factory ProgressState.initial() => const ProgressState._();

  @override
  List<Object?> get props => [meditation, breathing, stretching, journal, quiz, completed, treeGrowth, loading];

  ProgressState copyWith({
    Optional<bool?>? meditation,
    Optional<bool?>? breathing,
    Optional<bool?>? stretching,
    Optional<String?>? journal,
    Optional<bool?>? quiz,
    Optional<bool?>? completed,
    Optional<TreeGrowthDto?>? treeGrowth,
    Optional<bool?>? loading,
  }) {
    return ProgressState._(
      meditation: meditation?.isValid == true ? meditation?.value : this.meditation,
      breathing: breathing?.isValid == true ? breathing?.value : this.breathing,
      stretching: stretching?.isValid == true ? stretching?.value : this.stretching,
      journal: journal?.isValid == true ? journal?.value : this.journal,
      quiz: quiz?.isValid == true ? quiz?.value : this.quiz,
      completed: completed?.isValid == true ? completed?.value : this.completed,
      treeGrowth: treeGrowth?.isValid == true ? treeGrowth?.value : this.treeGrowth,
      loading: loading?.isValid == true ? loading?.value ?? false : this.loading,
    );
  }
}
