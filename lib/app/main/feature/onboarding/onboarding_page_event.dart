part of 'onboarding_page_bloc.dart';

sealed class OnboardingPageEvent extends BaseEvent {
  OnboardingPageEvent();

  factory OnboardingPageEvent.initial() => Initial._();

  factory OnboardingPageEvent.nextPage() => NextPage._();

  factory OnboardingPageEvent.skip() => Skip._();
}

class Initial extends OnboardingPageEvent {
  Initial._();
}

class NextPage extends OnboardingPageEvent {
  NextPage._();
}

class Skip extends OnboardingPageEvent {
  Skip._();
}
