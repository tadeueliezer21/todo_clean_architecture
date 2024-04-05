import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/unknow_error.dart';
import 'package:todo_clean_architecture/src/shared/infra/rest_template.dart';
import 'package:todo_clean_architecture/src/todo/core/data/datasource/abs_todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/failure/get_todo_failure.dart';
import 'package:todo_clean_architecture/src/todo/core/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/shared/infra/exception/http_error.dart';

class TodoDataSourceImpl extends RestTemplate<TodoModel>
    implements TodoDataSource {
  TodoDataSourceImpl(super.api, {required super.httpClient});

  @override
  Future<Either<Failure, TodoModel>> fetchOne(int id) async {
    try {
      final response = await super.findById('/todos/$id');

      return Right(response);
    } catch (err) {
      if (err is HttpError) {
        return Left(GetTodoFailure(message: err.message));
      }

      if (err is UnknowError) {
        return Left(GetTodoFailure(message: err.message));
      }

      throw const GetTodoFailure(message: 'Unexpected error');
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> fetchAll() async {
    try {
      final response = await super.findAll('/todos');

      return Right(response);
    } catch (err) {
      if (err is HttpError) {
        return Left(GetTodoFailure(message: err.message));
      }

      if (err is UnknowError) {
        return Left(GetTodoFailure(message: err.message));
      }
      throw const GetTodoFailure(message: 'Unexpected error');
    }
  }

  @override
  TodoModel fromJSON(Map map) {
    return TodoModel.fromJSON(map);
  }
}
