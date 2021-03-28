import 'package:enqueter_creator/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          Text('作成中'),
          Expanded(child: ListView()),
          Text('回答中'),
          Expanded(child: ListView()),
          Text('完了'),
          Expanded(child: ListView()),
        ],
      ),
    );
  }
}
