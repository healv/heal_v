import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/onboarding/onboarding_page.dart';
import 'package:heal_v/app/main/feature/onboarding/onboarding_page_bloc.dart';

import '../../app_routes.dart';

part 'onboarding_graph.g.dart';

@TypedGoRoute<OnboardingRoute>(path: OnboardingRoutes.onboarding, routes: <TypedRoute<RouteData>>[])
@immutable
base class OnboardingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => OnboardingPageBloc()..add(OnboardingPageEvent.initial()),
      child: const OnboardingPage(),
    );
  }
}

List<RouteBase> get $onboardingRoutes => $appRoutes;
