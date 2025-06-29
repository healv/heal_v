part of 'launch_page_bloc.dart';

sealed class LaunchPageSideEffect implements SideEffect {
  const LaunchPageSideEffect();

  factory LaunchPageSideEffect.navigateToOnboarding() => NavigateToOnboarding();
}

class NavigateToOnboarding extends LaunchPageSideEffect {}
