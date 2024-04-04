import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_architecture/src/shared/ioc/ioc.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_single_todo_cubit.dart';

class TodoDetailView extends StatefulWidget {
  final int id;

  const TodoDetailView({super.key, required this.id});

  @override
  State<TodoDetailView> createState() => _TodoDetailViewState();
}

class _TodoDetailViewState extends State<TodoDetailView> {
  @override
  void initState() {
    getSingleTodoCubit.loadTodo(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BlocBuilder<GetSingleTodoCubit, GetSingleTodoState>(
            bloc: getSingleTodoCubit,
            builder: (context, state) {
              if (state is GetSingleTodoLoading ||
                  state is GetSingleTodoInitial) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (state is GetSingleTodoError) {
                return Center(
                  child: Text(state.message),
                );
              }

              if (state is GetSingleTodoSuccess) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  color: state.todo.completed ? Colors.green : Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.todo.title,
                        style: const TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      Icon(state.todo.completed ? Icons.check : Icons.close)
                    ],
                  ),
                );
              }

              return const Offstage();
            },
          ),
        ],
      ),
    );
  }
}
