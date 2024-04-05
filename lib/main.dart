import 'package:flutter/material.dart';
import 'package:todo_clean_architecture/src/shared/ioc/ioc.dart' as it;
import 'package:todo_clean_architecture/src/todo/presenter/ui/view/list_todo_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await it.ioc();
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
