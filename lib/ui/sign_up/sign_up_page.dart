import 'package:enqueter_creator/ui/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
        key: watch(signUpViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              onChanged: watch(signUpViewModelProvider).changeEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signUpViewModelProvider).validateEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'パスワード',
                hintText: '6文字以上で入力してください',
              ),
              obscureText: true,
              onChanged: watch(signUpViewModelProvider).changePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signUpViewModelProvider).validatePassword,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'パスワード(確認用)'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signUpViewModelProvider).validateConfirmPassword,
            ),
            ElevatedButton(
              onPressed: watch(signUpViewModelProvider).signUp,
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
