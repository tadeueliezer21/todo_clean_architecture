import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:todo_clean_architecture/src/todo/core/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/data/models/todo_model.dart';

import '../../../../../utils/load_json.dart';

class MockClient extends Mock implements Client {}

void main() {
  late MockClient httpClientMock;
  late TodoDataSourceImpl todoDataSource;

  void registerFallBack() {
    registerFallbackValue(
      Uri.parse(
        'https://jsonplaceholder.typicode.com',
      ),
    );
  }

  setUp(
    () => {
      httpClientMock = MockClient(),
      todoDataSource =
          TodoDataSourceImpl('somethings', httpClient: httpClientMock),
      registerFallBack()
    },
  );

  void fetchAllTodosWithSuccess() {
    when(() => httpClientMock.get(
          any(),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => Response(getJSON('list_of_todos'), HttpStatus.ok),
    );
  }

  void fetchTodoWithSuccess() {
    when(() => httpClientMock.get(
          any(),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => Response(getJSON('todo'), HttpStatus.ok),
    );
  }

  group('Busca todos', () {
    test('Quando buscar por todos todos deve retornar sucesso', () async {
      fetchAllTodosWithSuccess();

      final response = await todoDataSource.findAll('/todos');

      expect(response.length, 200);

      var expectedTodos =
          (jsonDecode(getJSON('list_of_todos')) as List<dynamic>)
              .map((todo) => TodoModel.fromJSON(todo));

      expect(expectedTodos, equals(response));

      verify(() => httpClientMock.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Quando buscar por um todo deve retornar sucesso', () async {
      fetchTodoWithSuccess();

      final response = await todoDataSource.findById('/todos/195');

      var expectedTodo = TodoModel.fromJSON(
          jsonDecode(getJSON('todo')) as Map<String, dynamic>);

      expect(expectedTodo.id, equals(response.id));
      expect(expectedTodo.userId, equals(response.userId));
      expect(expectedTodo.title, equals(response.title));
      expect(expectedTodo.completed, equals(response.completed));

      verify(() => httpClientMock.get(any(), headers: any(named: 'headers')))
          .called(1);
    });
  });
}
