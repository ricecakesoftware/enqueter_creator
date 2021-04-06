import 'package:enqueter_creator/ui/questionnaire/questionnaire_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class QuestionnairePage extends ConsumerWidget {
  bool _refreshed = false;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (!_refreshed) {
      String? id = ModalRoute.of(context)!.settings.arguments as String?;
      if (id != null) {
        context.read(questionnaireViewModelProvider).id = id;
      }
      Future.delayed(Duration(microseconds: 100), () { context.read(questionnaireViewModelProvider).refresh(); });
      _refreshed = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('アンケート'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: context.read(questionnaireViewModelProvider).refresh
          ),
        ],
      ),
      body: Form(
        key: context.read(questionnaireViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'タイトル'),
              onChanged: context.read(questionnaireViewModelProvider).changeTitle,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: context.read(questionnaireViewModelProvider).validateTitle,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '内容'),
              onChanged: context.read(questionnaireViewModelProvider).changeContent,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: context.read(questionnaireViewModelProvider).validateContent,
            ),
            Row(
              children: [
                Text('回答期限'),
                TextButton(
                  onPressed: context.read(questionnaireViewModelProvider).selectDeadline,
                  child: Text(DateFormat('yyyy年MM月dd日').format(watch(questionnaireViewModelProvider).deadline)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('詳細'),
                ElevatedButton(
                  onPressed: context.read(questionnaireViewModelProvider).navigatePart,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: (watch(questionnaireViewModelProvider).parts.isEmpty) ? Text('なし') : ListView.builder(
                itemCount: watch(questionnaireViewModelProvider).parts.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Theme.of(context).dividerColor),
                      ),
                    ),
                    child: ListTile(
                      title: Text(watch(questionnaireViewModelProvider).parts[index].text),
                      trailing: Icon(Icons.edit),
                      onTap: () { context.read(questionnaireViewModelProvider).navigatePart(index: index); },
                    ),
                  );
                }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: context.read(questionnaireViewModelProvider).save,
                  child: Text('一時保存'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                  ),
                ),
                if (watch(questionnaireViewModelProvider).id.isNotEmpty) ElevatedButton(
                  onPressed: context.read(questionnaireViewModelProvider).publish,
                  child: Text('公開'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                if (watch(questionnaireViewModelProvider).id.isNotEmpty) ElevatedButton(
                  onPressed: context.read(questionnaireViewModelProvider).delete,
                  child: Text('削除'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).errorColor,
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
