import 'package:enqueter_creator/ui/part/part_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(title: Text('アンケート詳細')),
      body: Form(
        key: context.read(partViewModelProvider).formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'テキスト'),
              onChanged: context.read(partViewModelProvider).changeText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: context.read(partViewModelProvider).validateText,
            ),
            DropdownButton(
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  child: Text(
                    '自由入力',
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text(
                    'はい・いいえ',
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text(
                    '良い・やや良い・普通・やや悪い・悪い',
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text(
                    'あてはまる・ややあてはまる・どちらでもない・ややあやてはまらない・あてはまらない',
                    overflow: TextOverflow.ellipsis,
                  ),
                  value: 3,
                ),
              ],
              value: watch(partViewModelProvider).type,
              onChanged: context.read(partViewModelProvider).changeType,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('小問'),
                ElevatedButton(
                  onPressed: context.read(partViewModelProvider).addQuestion,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: (watch(partViewModelProvider).questions.isEmpty) ? Text('なし') : ListView.builder(
                  itemCount: watch(partViewModelProvider).questions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Theme.of(context).dividerColor),
                        ),
                      ),
                      child: ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(labelText: 'テキスト'),
                          initialValue: watch(partViewModelProvider).questions[index].text,
                          onChanged: (value) { context.read(partViewModelProvider).changeQuestionText(index, value); },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: context.read(partViewModelProvider).validateQuestionText,
                        ),
                        trailing: ElevatedButton(
                          onPressed: () { context.read(partViewModelProvider).deleteQuestion(index); },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    );
                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: context.read(partViewModelProvider).save,
                  child: Text('保存'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                if (watch(partViewModelProvider).id.isNotEmpty) ElevatedButton(
                  onPressed: context.read(partViewModelProvider).delete,
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
