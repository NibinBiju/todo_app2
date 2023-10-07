import 'package:hive/hive.dart';
import 'package:todo_app2/model/todo_model.dart';

class Dbhive {
  final _db = Hive.box('mytodo');

  void intialData() {
    TodoModel.mytodo = [
      TodoModel(title: 'title', description: 'description', date: 'date')
    ];
  }

  void addata() {
    _db.put('TODOLIST', TodoModel.mytodo);
    print('added');
  }

  void loaddata() {
    TodoModel.mytodo = _db.get('TODOLIST');
    print('load');
  }
}
