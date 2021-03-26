import 'package:enqueter_creator/ui/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('ユーザー情報')),
      body: Form(
        key: watch(profileViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'ニックネーム'),
              initialValue: watch(profileViewModelProvider).profile.displayName,
              onChanged: watch(profileViewModelProvider).changeDisplayName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(profileViewModelProvider).validateDisplayName,
            ),
            Row(
              children: [
                Text('性別'),
                RadioListTile(
                  title: Text('男性'),
                  value: 0,
                  groupValue: watch(profileViewModelProvider).profile.gender,
                  onChanged: watch(profileViewModelProvider).changeGender
                ),
                RadioListTile(
                    title: Text('女性'),
                    value: 1,
                    groupValue: watch(profileViewModelProvider).profile.gender,
                    onChanged: watch(profileViewModelProvider).changeGender
                ),
                RadioListTile(
                    title: Text('不明'),
                    value: 2,
                    groupValue: watch(profileViewModelProvider).profile.gender,
                    onChanged: watch(profileViewModelProvider).changeGender
                ),
              ],
            ),
            Row(
              children: [
                Text('生年月日'),
                TextButton(
                  onPressed: watch(profileViewModelProvider).selectBirthDate,
                  child: Text(DateFormat('yyyy/MM/dd').format(watch(profileViewModelProvider).profile.birthDate)),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: watch(profileViewModelProvider).register,
              child: Text((watch(profileViewModelProvider).profile.id.isEmpty) ? '登録' : '更新'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
