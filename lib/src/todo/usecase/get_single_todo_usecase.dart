import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';

class GetSingleTodoUseCase {
  final GetTodoRepository todoRepository;

  GetSingleTodoUseCase(this.todoRepository);

  Future<Either<Failure, TodoModel>> call(String id) async {
    return await todoRepository.getTodo(id);
  }
}
