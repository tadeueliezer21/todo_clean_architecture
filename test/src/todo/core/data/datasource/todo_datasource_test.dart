import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:todo_clean_architecture/src/todo/core/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/todo/core/failure/get_todo_failure.dart';

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

  void fetchTodoWithFailed(String message) {
    when(() => httpClientMock.get(
          any(),
          headers: any(named: 'headers'),
        )).thenThrow(HttpException(message));
  }

  void fetchTodoWithSuccess() {
    when(() => httpClientMock.get(
          any(),
          headers: any(named: 'headers'),
        )).thenAnswer(
      (_) async => Response(getJSON('todo'), HttpStatus.ok),
    );
  }

  group('Busca Todos', () {
    test('Quando buscar por todos todos deve retornar sucesso', () async {
      fetchAllTodosWithSuccess();

      final response = await todoDataSource.fetchAll();

      expect(true, response.isRight);

      late List<TodoModel> list;
      response.fold((left) => null, (right) => list = right);

      var expectedTodos =
          (jsonDecode(getJSON('list_of_todos')) as List<dynamic>)
              .map((todo) => TodoModel.fromJSON(todo));

      expect(expectedTodos, equals(list));

      verify(() => httpClientMock.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Quando buscar por todos deve retornar um HttpException', () async {
      const String message = 'Server error';

      fetchTodoWithFailed(message);

      final response = await todoDataSource.fetchAll();

      expect(true, response.isLeft);

      late GetTodoFailure exception;
      List<TodoModel>? todosExpectedNull;

      response.fold((left) => exception = left as GetTodoFailure,
          (right) => todosExpectedNull = right);

      late GetTodoFailure expectedFailure =
          const GetTodoFailure(message: message);

      expect(null, todosExpectedNull);
      expect(exception, expectedFailure);
      expect(expectedFailure.message, exception.message);

      verify(() => httpClientMock.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Quando buscar por um todo deve retornar sucesso', () async {
      fetchTodoWithSuccess();

      final response = await todoDataSource.fetchOne(195);

      expect(true, response.isRight);

      var expectedTodo = TodoModel.fromJSON(
          jsonDecode(getJSON('todo')) as Map<String, dynamic>);

      late TodoModel todo;

      response.fold((left) => null, (right) => todo = right);

      expect(expectedTodo.id, equals(todo.id));
      expect(expectedTodo.userId, equals(todo.userId));
      expect(expectedTodo.title, equals(todo.title));
      expect(expectedTodo.completed, equals(todo.completed));

      verify(() => httpClientMock.get(any(), headers: any(named: 'headers')))
          .called(1);
    });

    test('Quando buscar por todos deve retornar um HttpException', () async {
      const String message = 'Many request';

      fetchTodoWithFailed(message);

      final response = await todoDataSource.fetchOne(1);

      expect(true, response.isLeft);

      late GetTodoFailure exception;
      TodoModel? todoExpectedNull;

      response.fold((left) => exception = left as GetTodoFailure,
          (right) => todoExpectedNull = right);

      late GetTodoFailure expectedFailure =
          const GetTodoFailure(message: message);

      expect(null, todoExpectedNull);
      expect(exception, expectedFailure);
      expect(expectedFailure.message, exception.message);

      verify(() => httpClientMock.get(any(), headers: any(named: 'headers')))
          .called(1);
    });
  });
}
