import 'package:enqueter_creator/ui/questionnaire/questionnaire_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class QuestionnairePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(questionnaireViewModelProvider).id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('アンケート'),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: watch(questionnaireViewModelProvider).refresh
          ),
        ],
      ),
      body: Form(
        key: watch(questionnaireViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'タイトル'),
              onChanged: watch(questionnaireViewModelProvider).changeTitle,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(questionnaireViewModelProvider).validateTitle,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '内容'),
              onChanged: watch(questionnaireViewModelProvider).changeContent,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: watch(questionnaireViewModelProvider).validateContent,
            ),
            Row(
              children: [
                Text('回答期限'),
                TextButton(
                  onPressed: watch(questionnaireViewModelProvider).selectDeadline,
                  child: Text(DateFormat('yyyy年MM月dd日').format(watch(questionnaireViewModelProvider).deadline)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('詳細'),
                ElevatedButton(
                  onPressed: watch(questionnaireViewModelProvider).navigatePart,
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
                      onTap: () { watch(questionnaireViewModelProvider).navigatePart(index: index); },
                    ),
                  );
                }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: watch(questionnaireViewModelProvider).save,
                  child: Text('一時保存'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: watch(questionnaireViewModelProvider).publish,
                  child: Text('公開'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: watch(questionnaireViewModelProvider).delete,
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
