import 'package:hive/hive.dart';
import 'package:todo_app2/model/todo_model.dart';

class Dbhive {
  final db = Hive.box('mytodo');

  void addata() {
    db.put('todolist', TodoModel.mytodo);
  }

  void loaddata() {
    TodoModel.mytodo = db.get('todolist');
  }
}
