import 'package:flutter/material.dart';
import 'package:todo_clean_architecture/src/todo/presenter/ui/view/todo_detail_view.dart';

class EditButton extends StatelessWidget {
  final bool isCompleted;
  final int id;
  const EditButton({
    super.key,
    required this.isCompleted,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: 24,
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoDetailView(id: id),
            ),
          );
        },
      ),
    );
  }
}
