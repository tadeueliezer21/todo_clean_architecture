import 'package:flutter/material.dart';
import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';

class TodoWidget extends StatelessWidget {
  final TodoEntity todo;

  const TodoWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: todo.completed ? Colors.green : Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Icon(todo.completed ? Icons.check : Icons.close)
        ],
      ),
    );
  }
}
