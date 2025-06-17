import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/navigation/main/enums/bottom_navbar_enum.dart';
import 'package:heal_v/shared/feature/progress/progress_bloc.dart';
import 'package:heal_v/shared/feature/progress/progress_effect.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../navigation/main/quiz/quiz_graph.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage(this.navigationShell, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  StreamSubscription? _progressEffectsSubscription;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(backInterceptor);
    _progressEffectsSubscription = context.read<ProgressBloc>().sideEffects.listen(_listenProgressEffects);
  }

  bool backInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (widget.navigationShell.currentIndex != BottomNavBarEnum.home.index && context.canPop() == false) {
      widget.navigationShell.goBranch(BottomNavBarEnum.home.index, initialLocation: false);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          activeIcon: BottomNavBarEnum.home.svgAsset(context.primary),
          icon: BottomNavBarEnum.home.svgAsset(context.onBackground.withValues(alpha: 0.1)),
          label: tr(BottomNavBarEnum.home.labelKey),
        ),
        BottomNavigationBarItem(
          activeIcon: BottomNavBarEnum.meditation.svgAsset(context.primary),
          icon: BottomNavBarEnum.meditation.svgAsset(context.onBackground.withValues(alpha: 0.1)),
          label: tr(BottomNavBarEnum.meditation.labelKey),
        ),
        BottomNavigationBarItem(
          activeIcon: BottomNavBarEnum.stretching.svgAsset(context.primary),
          icon: BottomNavBarEnum.stretching.svgAsset(context.onBackground.withValues(alpha: 0.1)),
          label: tr(BottomNavBarEnum.stretching.labelKey),
        ),
        BottomNavigationBarItem(
          activeIcon: BottomNavBarEnum.breathing.svgAsset(context.primary),
          icon: BottomNavBarEnum.breathing.svgAsset(context.onBackground.withValues(alpha: 0.1)),
          label: tr(BottomNavBarEnum.breathing.labelKey),
        ),
        BottomNavigationBarItem(
          activeIcon: BottomNavBarEnum.profile.svgAsset(context.primary),
          icon: BottomNavBarEnum.profile.svgAsset(context.onBackground.withValues(alpha: 0.1)),
          label: tr(BottomNavBarEnum.profile.labelKey),
        ),
      ],
      currentIndex: widget.navigationShell.currentIndex,
      onTap: (index) => widget.navigationShell.goBranch(index),
    );
  }

  void _listenProgressEffects(ProgressEffect effect) async {
    switch (effect) {
      case DailyProgressFinished():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            QuizRoute().push(context);
            break;
          default:
            break;
        }
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backInterceptor);
    _progressEffectsSubscription?.cancel();
    super.dispose();
  }
}
