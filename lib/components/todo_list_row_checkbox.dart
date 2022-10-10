import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todo_list/view_models/todo_view_models.dart';

class TodoListRowCheckBox extends StatefulWidget {
  int index;

  TodoListRowCheckBox({required this.index});

  @override
  State<TodoListRowCheckBox> createState() => _TodoListRowCheckBoxState();
}

class _TodoListRowCheckBoxState extends State<TodoListRowCheckBox> {

  bool isCheckedCompleted = false;

  @override
  Widget build(BuildContext context) {
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

    TodoViewModels todoViewModels = context.watch<TodoViewModels>();

    return Container(
      // margin: ,
      // color: Colors.yellow,
      child: Transform.scale(
        scale: 1.0,
        child: Checkbox(
          value: isCheckedCompleted, // boolCategory[i]
          fillColor: MaterialStateProperty.resolveWith(getColor),
          checkColor: Colors.white,
          // checkColor: Colors.green,
          // activeColor: Colors.white,
          onChanged: (bool? value){
            isCheckedCompleted = value!;
            todoViewModels.setTodoListCompleted(value, widget.index);
            setState(() {});
          },
        ),
      ),
    );
  }
}
