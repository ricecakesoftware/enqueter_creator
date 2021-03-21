import 'package:enqueter_creator/ui/home/home_page.dart';
import 'package:enqueter_creator/ui/signin/signin_page.dart';
import 'package:enqueter_creator/ui/signup/signup_page.dart';
import 'package:enqueter_creator/utils/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'あんけたー',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      navigatorKey: watch(navigationServiceProvider).navigatorKey,
      routes: <String, WidgetBuilder> {
        '/home': (context) => HomePage(),
        '/signin': (context) => SigninPage(),
        '/signup': (context) => SignupPage(),
      },
      initialRoute: '/signin',
    );
  }
}
