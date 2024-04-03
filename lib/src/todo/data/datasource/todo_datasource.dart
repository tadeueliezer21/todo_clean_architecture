import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/unknow_error.dart';
import 'package:todo_clean_architecture/src/shared/infra/rest_template.dart';
import 'package:todo_clean_architecture/src/todo/exception/get_todos_exception.dart';
import 'package:todo_clean_architecture/src/todo/failure/get_todo_failure.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/http_error.dart';

class TodoDataSource extends RestTemplate<TodoModel> {
  TodoDataSource(super.api, {required super.httpClient});

  Future<Either<Failure, TodoModel>> getSingleTodo(String id) async {
    try {
      final response = await super.single('/todos/$id');

      return Right(response);
    } catch (err) {
      if (err is HttpError) {
        return Left(GetTodoFailure(message: err.message));
      }

      if (err is UnknowError) {
        return Left(GetTodoFailure(message: err.message));
      }

      throw GetTodosException('Unexpected error');
    }
  }

  Future<Either<Failure, List<TodoModel>>> getMultTodo() async {
    try {
      await Future.delayed(const Duration(seconds: 5));
      final response = await super.mult('/todos');

      return Right(response);
    } catch (err) {
      if (err is HttpError) {
        return Left(GetTodoFailure(message: err.message));
      }

      if (err is UnknowError) {
        return Left(GetTodoFailure(message: err.message));
      }
      throw GetTodosException('Unexpected error');
    }
  }

  @override
  TodoModel fromJSON(Map map) {
    return TodoModel.fromJSON(map);
  }
}
