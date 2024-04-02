import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';

class GetMultTodoUseCase {
  final TodoDataSource dataSource;

  GetMultTodoUseCase({required this.dataSource});

  Future<Either<Failure, List<TodoModel>>> call() async {
    return await dataSource.getMultTodo();
  }
}
