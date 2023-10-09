// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app2/model/todo_model.dart';
import 'package:todo_app2/views/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //intialize flutter
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  //open box
  var box = await Hive.openBox('mytodo');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}
