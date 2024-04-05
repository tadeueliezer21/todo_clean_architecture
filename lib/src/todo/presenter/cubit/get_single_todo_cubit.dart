import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_clean_architecture/src/todo/core/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/abs_get_single_todo_usecase.dart';
import 'package:todo_clean_architecture/src/todo/presenter/event/todo_event.dart';

part 'get_single_todo_state.dart';

class GetSingleTodoCubit extends Bloc<TodoEvent, GetSingleTodoState> {
  final GetSingleTodoUseCase getTodoUseCase;

  GetSingleTodoCubit(this.getTodoUseCase) : super(GetSingleTodoInitial()) {
    on<GetSingleTodoEvent>(_loadTodo);
  }

  Future<void> _loadTodo(
      GetSingleTodoEvent todoEvent, Emitter<GetSingleTodoState> emit) async {
    emit(GetSingleTodoLoading());

    final result = await getTodoUseCase(todoEvent.id);

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
