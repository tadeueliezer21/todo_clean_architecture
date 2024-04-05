import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {}

class GetSingleTodoEvent extends TodoEvent {
  final int id;

  GetSingleTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}
