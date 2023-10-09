import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  static List<TodoModel> mytodo = [];

  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final Color? color;

  TodoModel({
    required this.title,
    required this.description,
    required this.date,
    this.color,
  });
}
