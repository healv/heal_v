import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/feature/onboarding/model/onboarding_icons.dart';
import 'package:heal_v/app/main/feature/onboarding/onboarding_page_bloc.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../common/tools/localization_tools.dart';
import '../../../../navigation/auth/auth_graph.dart';
import 'model/onboarding_page_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends BlocDependentSideEffectState<OnboardingPage, OnboardingPageBloc, OnboardingPageEffect> {
  @override
  void initState() {
    super.initState();
    Store.set(key: StoreKey.isNotFirstRun, value: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocSelector<OnboardingPageBloc, OnboardingPageState, int>(
      selector: (OnboardingPageState state) => state.currentIndex ?? 0,
      builder: (BuildContext context, int currentIndex) {
        final page = pages[currentIndex];
        return Stack(
          children: [
            _image(context, page),
            _bottomColumn(context, currentIndex, page),
          ],
        );
      },
    );
  }

  Widget _image(BuildContext context, OnboardingPageModel page) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      color: context.quizDialogItemColor,
      child: Center(
        child: page.image.svgAsset(
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _bottomColumn(BuildContext context, int currentIndex, OnboardingPageModel page) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          color: context.background,
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            children: [
              _title(context, page),
              const SizedBox(height: 12),
              _description(context, page),
              const SizedBox(height: 32),
              _circles(context, currentIndex),
              const SizedBox(height: 32),
              _nextButton(context, currentIndex),
              const SizedBox(height: 12),
              _skipButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context, OnboardingPageModel page) {
    return Text(
      page.title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: context.onBackground,
      ),
    );
  }

  Widget _description(BuildContext context, OnboardingPageModel page) {
    return Text(
      page.description,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        color: context.onBackground,
      ),
    );
  }

  Widget _circles(BuildContext context, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages.length,
        (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == i ? context.primary : context.primary.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }

  Widget _nextButton(BuildContext context, int currentIndex) {
    return ElevatedButton(
      onPressed: () {
        context.read<OnboardingPageBloc>().add(OnboardingPageEvent.nextPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: context.primary,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(currentIndex == pages.length - 1 ? tr('getStarted') : tr('next')),
    );
  }

  Widget _skipButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<OnboardingPageBloc>().add(OnboardingPageEvent.skip());
      },
      child: Text(
        tr('skip'),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
          letterSpacing: 0.2,
          color: context.onBackground.withValues(alpha: 0.2),
        ),
      ),
    );
  }

  @override
  Future<void> handleSideEffect(OnboardingPageEffect effect) async {
    switch (effect) {
      case NavigateToSignIn():
        SignInRoute().go(context);
        break;
    }
  }
}
