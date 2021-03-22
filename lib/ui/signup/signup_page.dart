import 'package:enqueter_creator/ui/signup/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Form(
        key: watch(signupViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              onChanged: watch(signupViewModelProvider).changeEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signupViewModelProvider).validateEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'パスワード',
                hintText: '6文字以上で入力してください',
              ),
              obscureText: true,
              onChanged: watch(signupViewModelProvider).changePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signupViewModelProvider).validatePassword,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'パスワード(確認用)'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signupViewModelProvider).validateConfirmPassword,
            ),
            ElevatedButton(
              onPressed: watch(signupViewModelProvider).signup,
              child: Text('Sign up'),
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
