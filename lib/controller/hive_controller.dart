import 'package:hive_flutter/adapters.dart';
import 'package:todo_app2/controller/todolist_controllers.dart';
import 'package:todo_app2/model/todo_model.dart';

class Dbhive {
  final _db = Hive.box('mytodo');

  void updateData() {
    _db.put('TODOLIST', TodolistController.mytodo);
    // print('');
  }

  void loadData() {
    final List mytodo2 = _db.get('TODOLIST');
    TodolistController.mytodo = mytodo2
        .map((e) => TodoModel(
              title: e.title,
              description: e.description,
              date: e.date,
            ))
        .toList();
    print('load');
  }
}
