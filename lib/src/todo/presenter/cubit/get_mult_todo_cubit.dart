import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_clean_architecture/src/todo/data/entities/todo_entity.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_mult_todo_usecase.dart';

part 'get_mult_todo_state.dart';

class GetMultTodoCubit extends Cubit<GetMultTodoCubitState> {
  final GetMultTodoUseCase getMultTodoUseCase;

  GetMultTodoCubit(
    this.getMultTodoUseCase,
  ) : super(GetTodoCubitInitial()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    emit(GetTodoCubitLoading());

    final result = await getMultTodoUseCase.call();

    result.fold(
      (err) => emit(GetTodoCubitError(err.message)),
      (list) => emit(GetTodoCubitSuccess(list: list)),
    );
  }
}
