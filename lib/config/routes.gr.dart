// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../screens/screens.dart' as _i1;

class Routes extends _i2.RootStackRouter {
  Routes([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    InitialInfoScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.InitialInfoScreen());
    }
  };

  @override
  List<_i2.RouteConfig> get routes =>
      [_i2.RouteConfig(InitialInfoScreen.name, path: '/')];
}

/// generated route for
/// [_i1.InitialInfoScreen]
class InitialInfoScreen extends _i2.PageRouteInfo<void> {
  const InitialInfoScreen() : super(InitialInfoScreen.name, path: '/');

  static const String name = 'InitialInfoScreen';
}
