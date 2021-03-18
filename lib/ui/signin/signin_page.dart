import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign in')),
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
            child: Text('Sign in')
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/signup');
            },
            child: Text('Sing up')
          ),
        ],
      ),
    );
  }
}
