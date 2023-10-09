import 'package:todo_app2/controller/hive_controller.dart';
import 'package:todo_app2/model/todo_model.dart';

class TodolistController {
  List<TodoModel> mytodo = [
    TodoModel(title: 'name', description: 'description', date: 'date'),
  ];
  Dbhive dbhive = Dbhive();

  void addata(TodoModel todoModel) {
    mytodo.add(todoModel);
    dbhive.updateData();
  }

  void delete(int index) {
    mytodo.removeAt(index);
    dbhive.updateData();
  }
}
