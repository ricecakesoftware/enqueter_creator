import 'package:enqueter_creator/constants.dart';
import 'package:enqueter_creator/utils/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<DialogService> dialogServiceProvider = Provider((_) => DialogService());

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

  Future<DialogResult?> showYesNoDialog(String title, String content) async {
    final NavigatorKey navigatorKey = NavigatorKey();
    return await showDialog<DialogResult>(
      context: navigatorKey.value.currentContext!,
      builder: (_) =>
          AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text('はい'),
                onPressed: () => Navigator.pop(navigatorKey.value.currentContext!, DialogResult.Yes),
              ),
              TextButton(
                child: Text('いいえ'),
                onPressed: () => Navigator.pop(navigatorKey.value.currentContext!, DialogResult.No),
              ),
            ],
          ),
    );
  }

  Future<DateTime?> showDatePickerDialog(DateTime initialDate) async {
    final NavigatorKey navigatorKey = NavigatorKey();
    return await showDatePicker(
      locale: Locale('ja'),
      context: navigatorKey.value.currentContext!,
      initialDate: initialDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2099, 12, 31),
    );
  }

  Future<void> showCircularProgressIndicatorDialog(Future<void> Function() function) async {
    final NavigatorKey navigatorKey = NavigatorKey();
    try {
      showGeneralDialog(
          context: navigatorKey.value.currentContext!,
          barrierDismissible: false,
          pageBuilder: (context, animation, secondaryAnimation) {
            return Center(child: CircularProgressIndicator());
          }
      );
      await function();
    } finally {
      navigatorKey.value.currentState!.pop();
    }
  }
}
