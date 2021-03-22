import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigator_key.dart';

final Provider<NavigationService> navigationServiceProvider = Provider((ref) => NavigationService());

class NavigationService {
  Future<dynamic> push(String routeName, {Object? args}) {
    final NavigatorKey navigatorKey = NavigatorKey();
    return navigatorKey.value.currentState!.pushNamed(routeName, arguments: args);
  }

  Future<dynamic> pushReplacement(String routeName, {Object? args}) {
    final NavigatorKey navigatorKey = NavigatorKey();
    return navigatorKey.value.currentState!.pushReplacementNamed(routeName, arguments: args);
  }

  Future<dynamic> pushAndRemoveUntil(String routeName, {Object? args}) {
    final NavigatorKey navigatorKey = NavigatorKey();
    return navigatorKey.value.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: args);
  }

  bool pop() {
    final NavigatorKey navigatorKey = NavigatorKey();
    if (navigatorKey.value.currentState!.canPop()) {
      navigatorKey.value.currentState!.pop();
      return true;
    } else {
      return false;
    }
  }
}
