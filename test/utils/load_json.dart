import 'dart:convert';
import 'dart:io';

import 'package:todo_clean_architecture/src/todo/core/data/models/todo_model.dart';

String getJSON(String name) =>
    File('test/utils/resource/$name.json').readAsStringSync();

List<TodoModel> listOfTodos() {
  return (jsonDecode(getJSON('list_of_todos')) as List<dynamic>)
      .map((todo) => TodoModel.fromJSON(todo))
      .toList();
}

TodoModel getTodo() {
  return TodoModel.fromJSON(
      (jsonDecode(getJSON('todo')) as Map<String, dynamic>));
}
