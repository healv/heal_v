import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page.dart';
import 'package:heal_v/app/main/feature/breathing/breathing_page_bloc.dart';
import 'package:heal_v/app/main/feature/media/audio/meditation_breathing_audio_page_bloc.dart';
import 'package:heal_v/main.dart';

import '../../../app/main/feature/common/model/meditation_breathing_ui_model.dart';
import '../../../app/main/feature/media/audio/meditation_breathing_audio_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => MeditationBreathingAudioPageBloc()
            ..add(
              MeditationBreathingAudioPageEvent.initial(MeditationBreathing.fromMap(jsonDecode(breathing))),
            ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AudioPlayerWidgetBloc()
            ..add(
              AudioPlayerWidgetEvent.initial(MeditationBreathing.fromMap(jsonDecode(breathing))),
            ),
        ),
      ],
      child: const MeditationBreathingAudioPage(),
    );
  }
}

List<RouteBase> get $breathingRouteRoutes => $appRoutes;
