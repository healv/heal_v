import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/media/video/stretching_video_page.dart';
import 'package:heal_v/app/main/feature/media/video/stretching_video_page_bloc.dart';
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
