import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/main/feature/quiz/quiz_page.dart';
import '../../../app/main/feature/quiz/quiz_page_bloc.dart';
import '../../../main.dart';
import '../../app_routes.dart';

part 'quiz_graph.g.dart';

@TypedGoRoute<QuizRoute>(path: QuizRoutes.quiz, routes: <TypedRoute<RouteData>>[])
@immutable
base class QuizRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => QuizPageBloc(getIt.get())..add(QuizPageEvent.initial()),
      child: const QuizPage(),
    );
  }
}

List<RouteBase> get $quizRoutes => $appRoutes;
