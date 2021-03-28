import 'package:enqueter_creator/ui/home/home_page.dart';
import 'package:enqueter_creator/ui/profile/profile_page.dart';
import 'package:enqueter_creator/ui/sign_in/sign_in_page.dart';
import 'package:enqueter_creator/ui/sign_up/sign_up_page.dart';
import 'package:enqueter_creator/utils/navigator_key.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    Firebase.initializeApp();
    final NavigatorKey navigatorKey = NavigatorKey();
    return MaterialApp(
      title: 'あんけたー',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      navigatorKey: navigatorKey.value,
      routes: <String, WidgetBuilder> {
        '/home': (context) => HomePage(),
        '/sign_in': (context) => SignInPage(),
        '/sign_up': (context) => SignUpPage(),
        '/profile': (context) => ProfilePage(),
      },
      initialRoute: '/sign_in',
    );
  }
}
