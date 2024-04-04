import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';

class GetSingleTodoUseCase {
  final GetTodoRepository todoRepository;

  GetSingleTodoUseCase(this.todoRepository);

  Future<Either<Failure, TodoEntity>> call(int id) async {
    return await todoRepository.getTodo(id);
  }
}
