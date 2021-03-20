import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<NavigationService> navigationServiceProvider = Provider((ref) => NavigationService());

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  Future<dynamic> push(String routeName) {
    return _navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> pushReplacement(String routeName) {
    return _navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> pushAndRemoveUntil(String routeName) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false);
  }

  bool pop() {
    if (_navigatorKey.currentState!.canPop()) {
      _navigatorKey.currentState!.pop();
      return true;
    } else {
      return false;
    }
  }
}
