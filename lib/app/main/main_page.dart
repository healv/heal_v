import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/navigation/main/enums/bottom_navbar_enum.dart';
import 'package:heal_v/theme/ext/extension.dart';

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
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: BottomNavBarEnum.home.svgAsset(context.onBackground),
            selectedIcon: BottomNavBarEnum.home.svgAsset(context.primary),
            label: tr(BottomNavBarEnum.home.labelKey),
          ),
          NavigationDestination(
            icon: BottomNavBarEnum.meditation.svgAsset(context.onBackground),
            selectedIcon: BottomNavBarEnum.meditation.svgAsset(context.primary),
            label: tr(BottomNavBarEnum.meditation.labelKey),
          ),
          NavigationDestination(
            icon: BottomNavBarEnum.stretching.svgAsset(context.onBackground),
            selectedIcon: BottomNavBarEnum.stretching.svgAsset(context.primary),
            label: tr(BottomNavBarEnum.stretching.labelKey),
          ),
          NavigationDestination(
            icon: BottomNavBarEnum.breathing.svgAsset(context.onBackground),
            selectedIcon: BottomNavBarEnum.breathing.svgAsset(context.primary),
            label: tr(BottomNavBarEnum.breathing.labelKey),
          ),
          NavigationDestination(
            icon: BottomNavBarEnum.profile.svgAsset(context.onBackground),
            selectedIcon: BottomNavBarEnum.profile.svgAsset(context.primary),
            label: tr(BottomNavBarEnum.profile.labelKey),
          )
        ],
        elevation: 0,
        height: 64,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        backgroundColor: context.background,
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onNavigationDestinationSelected,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: Colors.transparent,
        animationDuration: Duration.zero,
      ),
    );
  }

  void _onNavigationDestinationSelected(int index) {
    if (index != widget.navigationShell.currentIndex) {
      widget.navigationShell.goBranch(index, initialLocation: false);
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(backInterceptor);
    super.dispose();
  }
}
