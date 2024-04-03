import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';

class GetMultTodoUseCase {
  final GetTodoRepository repository;

  GetMultTodoUseCase(this.repository);

  Future<Either<Failure, List<TodoModel>>> call() async {
    return await repository.getTodos();
  }
}
