import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_architecture/src/todo/data/datasource/todo_datasource.dart';
import 'package:http/http.dart' show Client;
import 'package:todo_clean_architecture/src/todo/data/repositories/todo_repository.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_mult_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_mult_todo_usecase.dart';
import 'package:todo_clean_architecture/src/todo/usecase/get_single_todo_usecase.dart';

void main() {
  final dataSource = TodoDataSource('https://jsonplaceholder.typicode.com',
      httpClient: Client());

  final repository = GetTodoRepository(dataSource);

  final multUseCase = GetMultTodoUseCase(repository);
  final singleUseCase = GetSingleTodoUseCase(repository);

  runApp(MainApp(
    multUseCase: multUseCase,
    singleUseCase: singleUseCase,
  ));
}

class MainApp extends StatelessWidget {
  final GetMultTodoUseCase multUseCase;
  final GetSingleTodoUseCase singleUseCase;

  const MainApp(
      {super.key, required this.multUseCase, required this.singleUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => GetMultTodoCubit(multUseCase))
            ],
            child: BlocBuilder<GetMultTodoCubit, GetMultTodoCubitState>(
                builder: (context, state) {
              if (state is GetTodoCubitLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
              if (state is GetTodoCubitSuccess) {
                return ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(state.list[index].title.toUpperCase()),
                        leading: state.list[index].completed
                            ? const Icon(Icons.check)
                            : const Icon(Icons.abc),
                      );
                    });
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }
}
