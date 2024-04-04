import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';

class GetTodoRepository {
  final TodoDataSource dataSource;

  const GetTodoRepository(this.dataSource);

  Future<Either<Failure, List<TodoEntity>>> getTodos() {
    return dataSource.getMultTodo();
  }

  Future<Either<Failure, TodoEntity>> getTodo(int id) {
    return dataSource.getSingleTodo(id);
  }
}
