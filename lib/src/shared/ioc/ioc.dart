import 'package:http/http.dart';
import 'package:todo_clean_architecture/src/todo/core/data/datasource/todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/data/datasource/abs_todo_datasource.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/abs_todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/core/data/repositories/todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_mult_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_single_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/abs_get_mult_todo_usecase.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/abs_get_single_todo_usecase.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/get_mult_todo_usecase.dart';
import 'package:todo_clean_architecture/src/todo/core/usecase/get_single_todo_usecase.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

const String api = 'https://jsonplaceholder.typicode.com';

Future<void> ioc() async {
  sl
    ..registerFactory<GetMultTodoCubit>(
      () => GetMultTodoCubit(sl<GetMultTodoUseCase>()),
    )
    ..registerFactory<GetSingleTodoCubit>(
        () => GetSingleTodoCubit(sl<GetSingleTodoUseCase>()))
    ..registerLazySingleton<GetSingleTodoUseCase>(
      () => GetSingleTodoUseCaseImpl(sl<GetTodoRepository>()),
    )
    ..registerLazySingleton<GetMultTodoUseCase>(
      () => GetMultTodoUseCaseImpl(sl<GetTodoRepository>()),
    )
    ..registerLazySingleton<GetTodoRepository>(
      () => GetTodoRepositoryImpl(sl<TodoDataSource>()),
    )
    ..registerLazySingleton<TodoDataSource>(
      () => TodoDataSourceImpl(api, httpClient: sl<Client>()),
    )
    ..registerLazySingleton<Client>(Client.new);
}
