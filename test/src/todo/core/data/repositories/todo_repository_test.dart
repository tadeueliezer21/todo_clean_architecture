import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_clean_architecture/src/todo/core/data/datasource/abs_todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/abs_todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/todo_repository.dart';

import '../../../../../utils/load_json.dart';

class MockTodoDatasource extends Mock implements TodoDataSource {}

void main() {
  late MockTodoDatasource todoDatasourceMock;
  late GetTodoRepository repository;
  setUp(() => {
        todoDatasourceMock = MockTodoDatasource(),
        repository = GetTodoRepositoryImpl(todoDatasourceMock)
      });
  group('TodoRepository', () {
    void executedGetTodosWithSuccess() {
      when(() => todoDatasourceMock.fetchAll())
          .thenAnswer((_) => Future(() async => Right(listOfTodos())));
    }

    void executedGetTodoWithSuccess() {
      when(() => todoDatasourceMock.fetchOne(any()))
          .thenAnswer((_) => Future(() async => Right(getTodo())));
    }

    test('Quando buscar todos deve executar com sucesso', () async {
      executedGetTodosWithSuccess();

      List<TodoEntity>? expectedTodos;

      final result = await repository.getTodos();

      expect(true, result.isRight);

      result.fold((left) => null, (right) => expectedTodos = right);

      expect(expectedTodos, listOfTodos());
    });

    test('Quando buscar um todo deve executar com sucesso', () async {
      executedGetTodoWithSuccess();

      TodoEntity? expectedTodo;

      final result = await repository.getTodo(195);

      expect(true, result.isRight);

      result.fold((left) => null, (right) => expectedTodo = right);

      expect(expectedTodo, getTodo());
    });
  });
}
