import 'package:flutter/material.dart';
import 'package:todo_clean_architecture/src/todo/presenter/view/list_todo_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoList(),
    );
  }
}
