import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/navigation/main/home/home_graph.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/shared/feature/auth/auth_bloc.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<StatefulWidget> createState() => _LaunchPageState();
}

final class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).add(AuthBlocEvent.initial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state.accessToken != null) {
          HomeRoute().go(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _body(context),
        );
      },
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: AppIcons.launcher.imageAsset(),
    );
  }
}
