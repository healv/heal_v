import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/flutter/widgets/framework.dart';
import 'package:heal_v/common/utils/resource.dart';
import 'package:heal_v/navigation/auth/auth_graph.dart';
import 'package:heal_v/navigation/main/home/home_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc_effect.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

final class _LaunchPageState extends BlocDependentSideEffectState<LaunchPage, AuthBloc, AuthBlocEffect> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AuthBlocEvent.initial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: AppIcons.launcher.imageAsset(),
    );
  }

  @override
  Future<void> handleSideEffect(AuthBlocEffect effect) async {
    switch (effect) {
      case LoggedOut():
        SignInRoute().go(context);
        break;
      case LoggedIn():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            HomeRoute().go(context);
            break;
          default:
            break;
        }
        break;
      case SignedUp():
        switch (effect.status) {
          case ResourceStatusEnum.success:
            HomeRoute().go(context);
            break;
          default:
            break;
        }
        break;
      case NotLoggedIn():
        SignInRoute().go(context);
        break;
      default:
        break;
    }
  }
}
