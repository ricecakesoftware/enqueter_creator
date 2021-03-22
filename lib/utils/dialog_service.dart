import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigator_key.dart';

final Provider<DialogService> dialogServiceProvider = Provider((ref) => DialogService());

class DialogService {
  Future<void> showAlertDialog(String title, String content) async {
    final NavigatorKey navigatorKey = NavigatorKey();
    await showDialog(
      context: navigatorKey.value.currentContext!,
      builder: (_) =>
        AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(navigatorKey.value.currentContext!),
            ),
          ],
        ),
    );
  }
}
