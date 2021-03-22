import 'package:flutter/material.dart';

class NavigatorKey {
  static final _instance = NavigatorKey._internal();
  final GlobalKey<NavigatorState> _value = new GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get value => _value;

  NavigatorKey._internal();

  factory NavigatorKey() => _instance;
}
