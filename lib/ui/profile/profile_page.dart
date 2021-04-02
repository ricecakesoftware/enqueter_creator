import 'package:enqueter_creator/ui/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('プロフィール')),
      body: Form(
        key: watch(profileViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'ニックネーム'),
              initialValue: watch(profileViewModelProvider).displayName,
              onChanged: watch(profileViewModelProvider).changeDisplayName,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(profileViewModelProvider).validateDisplayName,
            ),
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: watch(profileViewModelProvider).gender,
                  onChanged: watch(profileViewModelProvider).changeGender
                ),
                Text('男性'),
                Radio(
                    value: 1,
                    groupValue: watch(profileViewModelProvider).gender,
                    onChanged: watch(profileViewModelProvider).changeGender
                ),
                Text('女性'),
                Radio(
                    value: 2,
                    groupValue: watch(profileViewModelProvider).gender,
                    onChanged: watch(profileViewModelProvider).changeGender
                ),
                Text('不明'),
              ],
            ),
            Row(
              children: [
                Text('生年月日'),
                TextButton(
                  onPressed: watch(profileViewModelProvider).selectBirthDate,
                  child: Text(DateFormat('yyyy年MM月dd日').format(watch(profileViewModelProvider).birthDate)),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: watch(profileViewModelProvider).register,
              child: Text((watch(profileViewModelProvider).id.isEmpty) ? '登録' : '更新'),
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
