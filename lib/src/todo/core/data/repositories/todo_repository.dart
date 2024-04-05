import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/core/data/datasource/abs_todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/abs_todo_repository.dart';

class GetTodoRepositoryImpl implements GetTodoRepository {
  final TodoDataSource dataSource;

  const GetTodoRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodos() {
    return dataSource.fetchAll();
  }

  @override
  Future<Either<Failure, TodoEntity>> getTodo(int id) {
    return dataSource.fetchOne(id);
  }
}
