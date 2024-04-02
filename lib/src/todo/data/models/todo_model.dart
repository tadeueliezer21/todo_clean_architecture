import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel(
      {required super.userId,
      required super.id,
      required super.title,
      required super.completed});

  factory TodoModel.fromJSON(Map map) {
    return TodoModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
      completed: map['completed'] as bool,
    );
  }
}
