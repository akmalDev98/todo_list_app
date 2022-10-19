import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter_etiqa/todo_list/views/add_todo_list.dart';

import '../todo_list/view_models/todo_view_models.dart';


class TodoListRowCheckBox extends ConsumerWidget {
  int index;

  TodoListRowCheckBox({required this.index});

  bool isCheckedCompleted = false;

  @override
  Widget build(BuildContext context, ref) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }

    final todoViewModels = ref.watch(todoViewModelsProvider);

    return Container(
      // margin: ,
      // color: Colors.yellow,
      child: Transform.scale(
        scale: 1.0,
        child: Checkbox(
          value: todoViewModels.todoListModel[index].status, // boolCategory[i]
          fillColor: MaterialStateProperty.resolveWith(getColor),
          checkColor: Colors.white,
          // checkColor: Colors.green,
          // activeColor: Colors.white,
          onChanged: (bool? value){
            ref.read(todoViewModelsProvider).setTodoListCompleted(value!, index);
          },
        ),
      ),
    );
  }
}
