import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService instance = NavigationService._internal();

  factory NavigationService() {
    return instance;
  }

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic>? pushNamed(String route, [int? id] ) {
    return navigatorKey.currentState?.pushNamed(route, arguments: id);
  }

  void pop() {
    navigatorKey.currentState?.pop();
  }
}