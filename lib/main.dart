import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_mult_todo_usecase.dart';

void main() {
  final GetTodoRepository repository =
      GetTodoRepository(api: 'jsonplaceholder.typicode.com');

  final TodoDataSource dataSource = TodoDataSource(repository: repository);

  final useCase = GetMultTodoUseCase(dataSource: dataSource);

  runApp(MainApp(useCase: useCase));
}

class MainApp extends StatelessWidget {
  final GetMultTodoUseCase useCase;

  const MainApp({super.key, required this.useCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: TextButton(
          child: const Text('Click'),
          onPressed: () => {useCase.call()},
        ),
      )),
    );
  }
}
