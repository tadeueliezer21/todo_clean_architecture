import 'package:todo_clean_architecture/src/todo/data/models/todo_model.dart';
import 'package:todo_clean_architecture/src/shared/infra/request.dart';

class GetTodoRepository extends Request<TodoModel> {
  GetTodoRepository({required super.api});

  Future<List<TodoModel>> getTodos() {
    return super.mult('/todos');
  }

  Future<TodoModel> getTodo(String id) {
    return super.single('/todos/$id');
  }

  @override
  TodoModel fromJSON(Map map) {
    return TodoModel.fromJSON(map);
  }
}
