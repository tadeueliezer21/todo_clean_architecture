import 'package:http/http.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_mult_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_single_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_mult_todo_usecase.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_single_todo_usecase.dart';

final dataSource = TodoDataSource(
  'https://jsonplaceholder.typicode.com',
  httpClient: Client(),
);

final repository = GetTodoRepository(dataSource);

final multUseCase = GetMultTodoUseCase(repository);
final singleUseCase = GetSingleTodoUseCase(repository);

final getSingleTodoCubit = GetSingleTodoCubit(singleUseCase);
final getMultTodoCubit = GetMultTodoCubit(multUseCase);
