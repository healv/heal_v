import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page_bloc.dart';
import 'package:heal_v/app/main/feature/breathing/model/breathing_lessons.dart';
import 'package:heal_v/app/main/feature/media/audio/audio_page_bloc.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';
import 'package:heal_v/main.dart';

import '../../../app/main/feature/media/audio/audio_page.dart';
import '../../../common/widgets/media/audio/audio_player_widget_bloc.dart';
import '../../app_routes.dart';

part 'breathing_graph.g.dart';

@TypedGoRoute<BreathingRoute>(path: MainRoutes.breathing, routes: <TypedRoute<RouteData>>[])
@immutable
base class BreathingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<BreathingPageBloc>(
      create: (context) => BreathingPageBloc(getIt.get())..add(BreathingPageEvent.initial()),
      lazy: false,
      child: const BreathingPage(),
    );
  }
}

@TypedGoRoute<BreathingAudioRoute>(path: BreathingsRoutes.breathingAudio, routes: <TypedRoute<RouteData>>[])
@immutable
base class BreathingAudioRoute extends GoRouteData {
  final String breathing;

  const BreathingAudioRoute({required this.breathing});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final breathingLesson = BreathingLesson.fromJson(jsonDecode(breathing));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => AudioPageBloc()
            ..add(
              AudioPageEvent.initial(breathingLesson.title ?? emptyString, breathingLesson.description ?? emptyString, '${AuthConstants.baseHost}${breathingLesson.preview?.url ?? emptyString}'),
            ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AudioPlayerWidgetBloc()
            ..add(
              AudioPlayerWidgetEvent.initial('${AuthConstants.baseHost}${breathingLesson.media?.url ?? emptyString}'),
            ),
        ),
      ],
      child: const AudioPage(),
    );
  }
}

List<RouteBase> get $breathingRouteRoutes => $appRoutes;
