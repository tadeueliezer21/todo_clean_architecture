import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_architecture/src/shared/ioc/ioc.dart';
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_mult_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/presenter/widgets/edit_button.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Minhas tarefas',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getMultTodoCubit),
            BlocProvider(create: (context) => getSingleTodoCubit)
          ],
          child: BlocBuilder<GetMultTodoCubit, GetMultTodoCubitState>(
            bloc: getMultTodoCubit,
            builder: (context, state) {
              if (state is GetTodoCubitLoading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (state is GetTodoCubitSuccess) {
                return ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: EditButton(
                        isCompleted: state.list[index].completed,
                        id: state.list[index].id,
                      ),
                      title: Text(state.list[index].title.toUpperCase()),
                    );
                  },
                );
              }
              if (state is GetTodoCubitError) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Offstage();
            },
          ),
        ),
      ),
    );
  }
}
