import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/common/utils/navigation/safe_args.dart';

abstract base class RouteArgs<Args extends SafeArgs, Route extends GoRouteData, Result> {
  Args? get args;

  Route get route;

  Future<Result?> push(BuildContext context) {
    return context.push<Result>(location());
  }

  void go(BuildContext context) {
    context.go(location());
  }

  String encode() => json.encode(args?.toJson());

  String location();
}
