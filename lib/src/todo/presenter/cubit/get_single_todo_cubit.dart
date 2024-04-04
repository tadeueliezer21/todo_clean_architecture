import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_single_todo_usecase.dart';

part 'get_single_todo_state.dart';

class GetSingleTodoCubit extends Cubit<GetSingleTodoState> {
  final GetSingleTodoUseCase getTodoUseCase;

  GetSingleTodoCubit(this.getTodoUseCase) : super(GetSingleTodoInitial());

  Future<void> loadTodo(int id) async {
    emit(GetSingleTodoLoading());

    final result = await getTodoUseCase(id);

    result.fold(
      (err) => emit(
        GetSingleTodoError(err.message),
      ),
      (todo) => emit(
        GetSingleTodoSuccess(todo),
      ),
    );
  }
}
