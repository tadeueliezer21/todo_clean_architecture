import 'package:either_dart/either.dart';
import 'package:todo_clean_architecture/src/shared/failure/failure.dart';
import 'package:todo_clean_architecture/src/todo/core/data/models/todo_model.dart';

abstract class TodoDataSource {
  Future<Either<Failure, TodoModel>> fetchOne(int id);
  Future<Either<Failure, List<TodoModel>>> fetchAll();
}
