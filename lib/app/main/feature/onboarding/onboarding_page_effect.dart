part of 'onboarding_page_bloc.dart';

sealed class OnboardingPageEffect implements SideEffect {
  const OnboardingPageEffect();

  factory OnboardingPageEffect.navigateToSignIn() => NavigateToSignIn();
}

class NavigateToSignIn extends OnboardingPageEffect {}
