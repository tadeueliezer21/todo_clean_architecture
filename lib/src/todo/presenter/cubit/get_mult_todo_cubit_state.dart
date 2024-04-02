part of 'get_mult_todo_cubit.dart';

@immutable
abstract class GetMultTodoCubitState extends Equatable {}

final class GetTodoCubitInitial extends GetMultTodoCubitState {
  final List<TodoModel> list = [];
  @override
  List<Object?> get props => [];
}

final class GetTodoCubitLoading extends GetMultTodoCubitState {
  @override
  List<Object?> get props => [];
}

final class GetTodoCubitError extends GetMultTodoCubitState {
  @override
  List<Object?> get props => [];
}

final class GetTodoCubitSuccess extends GetMultTodoCubitState {
  final List<TodoModel> list;

  GetTodoCubitSuccess({required this.list});

  @override
  List<Object?> get props => [list];
}
