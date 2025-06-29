import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/bloc/base_event.dart';
import '../../../../common/bloc/base_state.dart';
import '../../../../common/bloc/side_effect/side_effect.dart';
import '../../../../common/bloc/side_effect/side_effect_bloc.dart';
import '../../../../common/dart/optional.dart';
import '../../../../common/tools/localization_tools.dart';
import 'model/onboarding_icons.dart';
import 'model/onboarding_page_model.dart';

part 'onboarding_page_effect.dart';

part 'onboarding_page_event.dart';

part 'onboarding_page_state.dart';

class OnboardingPageBloc extends SideEffectBloc<OnboardingPageEvent, OnboardingPageState, OnboardingPageEffect> {
  OnboardingPageBloc() : super(OnboardingPageState.initial()) {
    on<Initial>(_handleInitialEvent);
    on<NextPage>(_handleNextPageEvent);
    on<Skip>(_handleSkipEvent);
  }

  Future<void> _handleInitialEvent(Initial event, Emitter<OnboardingPageState> emitter) async {}

  Future<void> _handleNextPageEvent(NextPage event, Emitter<OnboardingPageState> emitter) async {
    if ((state.currentIndex ?? 0) < pages.length - 1) {
      emitter(state.copyWith(currentIndex: Optional.value((state.currentIndex ?? 0) + 1)));
    } else {
      addSideEffect(OnboardingPageEffect.navigateToSignIn());
    }
  }

  Future<void> _handleSkipEvent(Skip event, Emitter<OnboardingPageState> emitter) async {
    addSideEffect(OnboardingPageEffect.navigateToSignIn());
  }
}

final List<OnboardingPageModel> pages = [
  OnboardingPageModel(
    image: OnboardingIcons.onboarding1,
    title: tr('reconnectWithYourself'),
    description: tr('startYourDayWithMeditation'),
  ),
  OnboardingPageModel(
    image: OnboardingIcons.onboarding2,
    title: tr('followYourHealingJourney'),
    description: tr('completeYourDailyGoals'),
  ),
  OnboardingPageModel(
    image: OnboardingIcons.onboarding3,
    title: tr('exploreGuidedPractices'),
    description: tr('fromEmotionalReleaseToSelfCompassion'),
  ),
  OnboardingPageModel(
    image: OnboardingIcons.onboarding4,
    title: tr('reflectThroughDailyQuiz'),
    description: tr('answerSoft'),
  ),
  OnboardingPageModel(
    image: OnboardingIcons.onboarding5,
    title: tr('trackProgress'),
    description: tr('logYourReflections'),
  ),
];
