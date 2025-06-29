part of 'onboarding_page_bloc.dart';

@immutable
class OnboardingPageState extends BaseState {
  final int? currentIndex;

  const OnboardingPageState._({
    this.currentIndex,
  });

  factory OnboardingPageState.initial() => const OnboardingPageState._(currentIndex: 0);

  @override
  List<Object?> get props => [currentIndex];

  OnboardingPageState copyWith({
    Optional<int?>? currentIndex,
  }) {
    return OnboardingPageState._(
      currentIndex: currentIndex?.isValid == true ? currentIndex?.value : this.currentIndex,
    );
  }
}
