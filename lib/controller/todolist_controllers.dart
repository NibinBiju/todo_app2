import 'package:hive/hive.dart';
import 'package:todo_app2/controller/hive_controller.dart';
import 'package:todo_app2/model/todo_model.dart';

class TodolistController {
  Dbhive dbhive = Dbhive();
  final db = Hive.box('mytodo');

  void addata(TodoModel todoModel) {
    TodoModel.mytodo.add(todoModel);
    dbhive.addata();
  }

  void delete(int index) {
    TodoModel.mytodo.removeAt(index);
    dbhive.addata();
  }
}
