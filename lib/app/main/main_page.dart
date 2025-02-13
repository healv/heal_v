import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/navigation/main/enums/bottom_navbar_enum.dart';
import 'package:heal_v/res/images/app_icons.dart';

class MainPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage(this.navigationShell, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(backInterceptor);
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
          icon: AppIcons.home.svgAsset(),
          label: tr(BottomNavBarEnum.home.labelKey),
        ),
        BottomNavigationBarItem(
          icon: AppIcons.meditation.svgAsset(),
          label: tr(BottomNavBarEnum.meditation.labelKey),
        ),
        BottomNavigationBarItem(
          icon: AppIcons.stretching.svgAsset(),
          label: tr(BottomNavBarEnum.stretching.labelKey),
        ),
        BottomNavigationBarItem(
          icon: AppIcons.breathing.svgAsset(),
          label: tr(BottomNavBarEnum.breathing.labelKey),
        ),
        BottomNavigationBarItem(
          icon: AppIcons.profile.svgAsset(),
          label: tr(BottomNavBarEnum.profile.labelKey),
        ),
      ],
      currentIndex: widget.navigationShell.currentIndex,
      onTap: (index) => widget.navigationShell.goBranch(index),
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backInterceptor);
    super.dispose();
  }
}
