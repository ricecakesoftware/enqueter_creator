import 'package:flutter/material.dart';

class NavigatorKey {
  static final _instance = NavigatorKey._internal();
  GlobalKey<NavigatorState> _value = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get value => _value;

  NavigatorKey._internal();

  factory NavigatorKey() => _instance;
}
