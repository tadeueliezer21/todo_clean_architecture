import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/core/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/abs_todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/abs_get_mult_todo_usecase.dart';

class GetMultTodoUseCaseImpl implements GetMultTodoUseCase {
  final GetTodoRepository repository;

  GetMultTodoUseCaseImpl(this.repository);

  @override
  Future<Either<Failure, List<TodoEntity>>> call() async {
    return await repository.getTodos();
  }
}
