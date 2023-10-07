import 'package:flutter/material.dart';

class TodoModel {
  static List<TodoModel> mytodo = [
    TodoModel(
        title: 'homework',
        description: 'ckkahbkshkajhka',
        date: '12-10-2023',
        color: Colors.blueAccent)
  ];

  final String title;
  final String description;
  final String date;
  final Color? color;

  TodoModel({
    required this.title,
    required this.description,
    required this.date,
    this.color,
  });
}
