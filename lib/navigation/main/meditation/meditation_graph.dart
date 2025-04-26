import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/common/model/meditation_breathing_ui_model.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_details/meditation_details_page.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_details/meditation_details_page_bloc.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/main.dart';

import '../../../app/main/feature/media/audio/meditation_breathing_audio_page.dart';
import '../../../app/main/feature/media/audio/meditation_breathing_audio_page_bloc.dart';
import '../../../common/widgets/media/audio/audio_player_widget_bloc.dart';
import '../../app_routes.dart';

part 'meditation_graph.g.dart';

@TypedGoRoute<MeditationRoute>(path: MainRoutes.meditation, routes: <TypedRoute<RouteData>>[])
@immutable
base class MeditationRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<MeditationPageBloc>(
      create: (context) => MeditationPageBloc(getIt.get())..add(MeditationPageEvent.initial()),
      lazy: false,
      child: const MeditationPage(),
    );
  }
}

@TypedGoRoute<MeditationAudioRoute>(path: MeditationsRoutes.meditationAudio, routes: <TypedRoute<RouteData>>[])
@immutable
base class MeditationAudioRoute extends GoRouteData {
  final String breathing;

  const MeditationAudioRoute({required this.breathing});

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

@immutable
base class MeditationNestedMeditationDetailsRoute extends GoRouteData {
  final String meditations;

  const MeditationNestedMeditationDetailsRoute({required this.meditations});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      lazy: false,
      create: (_) => MeditationDetailsPageBloc(),
      child: MeditationDetailsPage(
        meditations: (jsonDecode(meditations) as List<dynamic>).map((e) => MeditationBreathing.fromMap(e)).toList(),
      ),
    );
  }
}

List<RouteBase> get $meditationRoutes => $appRoutes;
