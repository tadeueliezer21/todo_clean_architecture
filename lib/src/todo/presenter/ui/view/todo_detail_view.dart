import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_clean_architecture/src/shared/ioc/ioc.dart' as it;
import 'package:todo_clean_architecture/src/todo/presenter/cubit/get_single_todo_cubit.dart';
import 'package:todo_clean_architecture/src/todo/presenter/event/todo_event.dart';
import 'package:todo_clean_architecture/src/todo/presenter/ui/widgets/todo_widget.dart';

class TodoDetailView extends StatefulWidget {
  final int id;

  const TodoDetailView({super.key, required this.id});

  @override
  State<TodoDetailView> createState() => _TodoDetailViewState();
}

class _TodoDetailViewState extends State<TodoDetailView> {
  @override
  void initState() {
    it.sl<GetSingleTodoCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            var cubit = it.sl<GetSingleTodoCubit>();
            cubit.add(GetSingleTodoEvent(widget.id));
            return cubit;
          }),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<GetSingleTodoCubit, GetSingleTodoState>(
              builder: (context, state) {
                if (state is GetSingleTodoInitial) {}

                if (state is GetSingleTodoLoading) {
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
                  return TodoWidget(todo: state.todo);
                }

                return const Offstage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
