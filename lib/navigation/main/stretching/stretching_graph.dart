import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/media/video/stretching_video_page.dart';
import 'package:heal_v/app/main/feature/media/video/stretching_video_page_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/details/stretching_deetails_page.dart';
import 'package:heal_v/app/main/feature/stretching/details/stretching_details_page_bloc.dart';
import 'package:heal_v/app/main/feature/stretching/model/stretching_lessons_ui_model.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page.dart';
import 'package:heal_v/app/main/feature/stretching/stretching_page_bloc.dart';
import 'package:heal_v/common/widgets/media/video/video_player_widget_bloc.dart';

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
  final String stretchingLesson;
  final String weekTitle;

  const StretchingDetailsRoute({
    required this.stretchingLesson,
    required this.weekTitle,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<StretchingDetailsPageBloc>(
      create: (_) => StretchingDetailsPageBloc(getIt.get())
        ..add(
          StretchingDetailsPageEvent.initial(StretchingLesson.fromMap(jsonDecode(stretchingLesson)), weekTitle),
        ),
      child: const StretchingDetailsPage(),
    );
  }
}

@TypedGoRoute<StretchingVideoRoute>(path: StretchingRoutes.stretchingVideo, routes: <TypedRoute<RouteData>>[])
@immutable
base class StretchingVideoRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StretchingVideoPageBloc>(create: (_) => StretchingVideoPageBloc()),
        BlocProvider<VideoPlayerWidgetBloc>(create: (_) => VideoPlayerWidgetBloc()..add(VideoPlayerWidgetEvent.initial())),
      ],
      child: const StretchingVideoPage(),
    );
  }
}

List<RouteBase> get $stretchingRouteRoutes => $appRoutes;
