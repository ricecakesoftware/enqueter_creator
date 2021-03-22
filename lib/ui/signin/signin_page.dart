import 'package:enqueter_creator/ui/signin/signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
      body: Form(
        key: watch(signinViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'メールアドレス'),
              onChanged: watch(signinViewModelProvider).changeEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signinViewModelProvider).validateEmail,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'パスワード'),
              obscureText: true,
              onChanged: watch(signinViewModelProvider).changePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(signinViewModelProvider).validatePassword,
            ),
            ElevatedButton(
              onPressed: watch(signinViewModelProvider).signin,
              child: Text('Sign in'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
            ElevatedButton(
              onPressed: watch(signinViewModelProvider).navigateSignup,
              child: Text('Sing up'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
