import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/exception/get_todos_exception.dart';
import 'package:todo_clean_architecture/src/todo/failure/get_todo_failure.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/http_error.dart';

class TodoDataSource {
  final GetTodoRepository repository;

  TodoDataSource({required this.repository});

  Future<Either<Failure, TodoModel>> getSingleTodo(String id) async {
    try {
      final response = await repository.getTodo(id);

      return Right(response);
    } catch (err) {
      if (err is GetTodosException) {
        return Left(GetTodoFailure(message: err.message));
      }

      if (err is HttpError) {
        return Left(GetTodoFailure(message: err.message));
      }

      throw GetTodoFailure(message: 'Unexpected error');
    }
  }

  Future<Either<Failure, List<TodoModel>>> getMultTodo() async {
    try {
      final response = await repository.getTodos();

      return Right(response);
    } catch (err) {
      if (err is GetTodosException) {
        return Left(GetTodoFailure(message: err.message));
      }

      if (err is HttpError) {
        return Left(GetTodoFailure(message: err.message));
      }

      throw GetTodoFailure(message: 'Unexpected error');
    }
  }
}
