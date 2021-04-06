import 'dart:async';

import 'package:enqueter_creator/ui/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  bool _refreshed = false;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (!_refreshed) {
      Future.delayed(Duration(microseconds: 100), () { context.read(homeViewModelProvider).refresh(); });
      _refreshed = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('一覧'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: context.read(homeViewModelProvider).refresh
          ),
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: context.read(homeViewModelProvider).navigateProfile
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('作成中'),
              ElevatedButton(
                onPressed: context.read(homeViewModelProvider).navigateQuestionnaire,
                child: Icon(Icons.add),
              ),
            ],
          ),
          Expanded(
            child: (watch(homeViewModelProvider).creatings.isEmpty) ? Text('なし') : ListView.builder(
              itemCount: watch(homeViewModelProvider).creatings.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: ListTile(
                    title: Text(watch(homeViewModelProvider).creatings[index].title),
                    trailing: ElevatedButton(
                      onPressed: () {
                        watch(homeViewModelProvider).navigateQuestionnaire(id: watch(homeViewModelProvider).creatings[index].id);
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                );
              }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('回答中'),
            ],
          ),
          Expanded(
            child: (watch(homeViewModelProvider).answerings.isEmpty) ? Text('なし') : ListView.builder(
              itemCount: watch(homeViewModelProvider).answerings.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: ListTile(
                    title: Text(watch(homeViewModelProvider).answerings[index].title),
                  ),
                );
              }
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('完了'),
            ],
          ),
          Expanded(
            child: (watch(homeViewModelProvider).finishings.isEmpty) ? Text('なし') : ListView.builder(
              itemCount: watch(homeViewModelProvider).finishings.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: ListTile(
                    title: Text(watch(homeViewModelProvider).finishings[index].title),
                    trailing: ElevatedButton(
                      onPressed: () {
                        watch(homeViewModelProvider).navigateQuestionnaire(id: watch(homeViewModelProvider).finishings[index].id);
                      },
                      child: Icon(Icons.arrow_right),
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
