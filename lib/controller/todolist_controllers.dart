import 'package:share_plus/share_plus.dart';
import 'package:todo_app2/controller/hive_controller.dart';
import 'package:todo_app2/model/todo_model.dart';

class TodolistController {
  Dbhive dbhive = Dbhive();
  static List<TodoModel> mytodo = [];

  void addata(TodoModel todoModel) {
    mytodo.add(todoModel);
    dbhive.updateData();
  }

  void delete(int index) {
    mytodo.removeAt(index);
    dbhive.updateData();
  }

  void shareData(TodoModel todoModel) {
    Share.share(
        '${todoModel.title}\n${todoModel.description}\n${todoModel.date}');
  }
}
