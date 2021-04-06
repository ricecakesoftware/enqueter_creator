import 'package:enqueter_creator/ui/sign_up/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('あんけたーアカウント登録')),
      body: Form(
        key: context.read(signUpViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              onChanged: context.read(signUpViewModelProvider).changeEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: context.read(signUpViewModelProvider).validateEmail,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'パスワード',
                hintText: '6文字以上で入力してください',
              ),
              obscureText: true,
              onChanged: context.read(signUpViewModelProvider).changePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: context.read(signUpViewModelProvider).validatePassword,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'パスワード(確認用)'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: context.read(signUpViewModelProvider).validateConfirmPassword,
            ),
            ElevatedButton(
              onPressed: context.read(signUpViewModelProvider).signUp,
              child: Text('アカウント登録'),
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
