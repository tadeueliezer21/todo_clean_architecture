part of 'get_single_todo_cubit.dart';

sealed class GetSingleTodoState extends Equatable {
  const GetSingleTodoState();

  @override
  List<Object> get props => [];
}

final class GetSingleTodoInitial extends GetSingleTodoState {}

final class GetSingleTodoLoading extends GetSingleTodoState {}

final class GetSingleTodoSuccess extends GetSingleTodoState {
  final TodoEntity todo;

  const GetSingleTodoSuccess(this.todo);

  @override
  List<Object> get props => [todo];
}

final class GetSingleTodoError extends GetSingleTodoState {
  final String message;

  const GetSingleTodoError(this.message);

  @override
  List<Object> get props => [message];
}
