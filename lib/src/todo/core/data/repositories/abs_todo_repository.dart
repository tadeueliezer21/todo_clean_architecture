import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/core/data/entities/todo_entity.dart';

abstract class GetTodoRepository {
  Future<Either<Failure, List<TodoEntity>>> getTodos();

  Future<Either<Failure, TodoEntity>> getTodo(int id);
}
