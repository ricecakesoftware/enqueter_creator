import 'package:enqueter_creator/utils/navigator_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<NavigationService> navigationServiceProvider = Provider((_) => NavigationService());

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

  bool pop({Object? result}) {
    final NavigatorKey navigatorKey = NavigatorKey();
    if (navigatorKey.value.currentState!.canPop()) {
      navigatorKey.value.currentState!.pop(result);
      return true;
    } else {
      return false;
    }
  }
}
