import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/stretching/details/stretching_details_page.dart';
import 'package:heal_v/app/main/feature/stretching/details/stretching_details_page_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page_bloc.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget_bloc.dart';
import 'package:heal_v/feature/heal_v/api/auth/utils/auth_constants.dart';

import '../../../app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import '../../../app/main/feature/stretching/video/stretching_video_page.dart';
import '../../../app/main/feature/stretching/video/stretching_video_page_bloc.dart';
import '../../../main.dart';
import '../../app_routes.dart';

part 'stretching_graph.g.dart';

@TypedGoRoute<StretchingRoute>(path: MainRoutes.stretching, routes: <TypedRoute<RouteData>>[])
@immutable
base class StretchingRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StretchingPageBloc>(
      create: (context) => StretchingPageBloc(getIt.get())..add(StretchingPageEvent.initial()),
      lazy: false,
      child: const StretchingPage(),
    );
  }
}

@TypedGoRoute<StretchingDetailsRoute>(path: StretchingRoutes.stretchingDetails, routes: <TypedRoute<RouteData>>[])
@immutable
base class StretchingDetailsRoute extends GoRouteData {
  final String weekTitle;
  final String weekId;
  final String lessonId;

  const StretchingDetailsRoute({
    required this.weekTitle,
    required this.weekId,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StretchingDetailsPageBloc>(
      create: (_) => StretchingDetailsPageBloc(getIt.get())
        ..add(
          StretchingDetailsPageEvent.initial(weekTitle: weekTitle, weekId: weekId, lessonId: lessonId),
        ),
      child: const StretchingDetailsPage(),
    );
  }
}

@TypedGoRoute<StretchingVideoRoute>(path: StretchingRoutes.stretchingVideo, routes: <TypedRoute<RouteData>>[])
@immutable
base class StretchingVideoRoute extends GoRouteData {
  final String stretchingLesson;

  const StretchingVideoRoute({required this.stretchingLesson});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final lesson = StretchingLesson.fromJson(jsonDecode(stretchingLesson));
    return MultiBlocProvider(
      providers: [
        BlocProvider<StretchingVideoPageBloc>(
          create: (_) => StretchingVideoPageBloc()..add(StretchingVideoPageEvent.initial(lesson)),
        ),
        BlocProvider<VideoPlayerWidgetBloc>(
          create: (_) => VideoPlayerWidgetBloc()
            ..add(VideoPlayerWidgetEvent.initial(
              '${AuthConstants.baseHost}${lesson.media?.url}',
              Duration(seconds: lesson.duration ?? 0),
            )),
        ),
      ],
      child: const StretchingVideoPage(),
    );
  }
}

List<RouteBase> get $stretchingRouteRoutes => $appRoutes;
