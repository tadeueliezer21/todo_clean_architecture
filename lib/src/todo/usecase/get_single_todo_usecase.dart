import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';

class GetSingleTodoUseCase {
  final TodoDataSource dataSource;

  GetSingleTodoUseCase({required this.dataSource});

  Future<Either<Failure, TodoModel>> call(String id) async {
    return await dataSource.getSingleTodo(id);
  }
}
