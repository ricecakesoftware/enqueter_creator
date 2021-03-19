import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'メールアドレス'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'パスワード'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Sign up'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
