import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';

class GetMultTodoUseCase {
  final GetTodoRepository repository;

  GetMultTodoUseCase(this.repository);

  Future<Either<Failure, List<TodoEntity>>> call() async {
    return await repository.getTodos();
  }
}
