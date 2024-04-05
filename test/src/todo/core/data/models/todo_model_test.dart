import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_clean_architecture/src/todo/core/data/models/todo_model.dart';

import '../../../../../utils/load_json.dart';

void main() {
  group('TodoModel', () {
    test('Ao transformar em JSON deve transformar com exito os dados', () {
      final json = jsonDecode(getJSON('todo')) as Map<String, dynamic>;

      const todoExpected = TodoModel(
        userId: 10,
        id: 195,
        title: 'rerum ex veniam mollitia voluptatibus pariatur',
        completed: true,
      );

      final todo = TodoModel.fromJSON(json);

      expect(todo, todoExpected);
    });
  });
}
