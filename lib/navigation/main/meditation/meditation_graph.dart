import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/common/model/lesson_type_enum.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page.dart';
import 'package:heal_v/app/main/feature/meditation/meditation_page_bloc.dart';
import 'package:heal_v/app/main/feature/meditation/model/meditation_lessons.dart';
import 'package:heal_v/main.dart';

import '../../../app/main/feature/media/audio/audio_page.dart';
import '../../../app/main/feature/media/audio/audio_page_bloc.dart';
import '../../../common/utils/constants.dart';
import '../../../common/widgets/media/audio/audio_player_widget_bloc.dart';
import '../../../feature/heal_v/api/auth/utils/auth_constants.dart';
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
  final String meditation;
  final String weekId;

  const MeditationAudioRoute({required this.meditation, required this.weekId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final meditationLesson = MeditationLesson.fromJson(jsonDecode(meditation));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => AudioPageBloc(meditationsRepo: getIt.get())
            ..add(
              AudioPageEvent.initial(
                lessonTypeEnum: LessonTypeEnum.meditation,
                id: meditationLesson.id ?? emptyString,
                weekId: weekId,
                title: meditationLesson.title ?? emptyString,
                description: meditationLesson.description ?? emptyString,
                previewUrl: '${AuthConstants.baseHost}${meditationLesson.preview?.url ?? emptyString}',
                isCompleted: meditationLesson.isCompleted ?? false,
              ),
            ),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => AudioPlayerWidgetBloc()
            ..add(
              AudioPlayerWidgetEvent.initial('${AuthConstants.baseHost}${meditationLesson.media?.url ?? emptyString}'),
            ),
        ),
      ],
      child: const AudioPage(),
    );
  }
}

List<RouteBase> get $meditationRoutes => $appRoutes;
