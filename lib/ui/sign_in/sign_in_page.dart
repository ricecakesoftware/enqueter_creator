import 'package:enqueter_creator/ui/sign_in/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('あんけたー')),
      body: Form(
        key: watch(signInViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              onChanged: watch(signInViewModelProvider).changeEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signInViewModelProvider).validateEmail,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'パスワード'),
              obscureText: true,
              onChanged: watch(signInViewModelProvider).changePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signInViewModelProvider).validatePassword,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: watch(signInViewModelProvider).signIn,
                  child: Text('ログイン'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: watch(signInViewModelProvider).navigateSignUp,
                  child: Text('アカウント登録'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
