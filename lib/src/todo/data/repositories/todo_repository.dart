import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';

class GetTodoRepository {
  final TodoDataSource dataSource;

  GetTodoRepository(this.dataSource);

  Future<Either<Failure, List<TodoModel>>> getTodos() {
    return dataSource.getMultTodo();
  }

  Future<Either<Failure, TodoModel>> getTodo(String id) {
    return dataSource.getSingleTodo(id);
  }
}
