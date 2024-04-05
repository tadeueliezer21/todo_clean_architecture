import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/core/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/abs_todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/abs_get_single_todo_usecase.dart';

class GetSingleTodoUseCaseImpl implements GetSingleTodoUseCase {
  final GetTodoRepository todoRepository;

  GetSingleTodoUseCaseImpl(this.todoRepository);

  @override
  Future<Either<Failure, TodoEntity>> call(int id) async {
    return await todoRepository.getTodo(id);
  }
}
