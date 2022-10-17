import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter_etiqa/todo_list/view_models/todo_view_models.dart';
import 'package:todo_list_flutter_etiqa/utils/constant.dart';

import '../../components/todo_list_row.dart';
import 'add_todo_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TodoViewModels todoViewModels = context.watch<TodoViewModels>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("To-Do List",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoViewModels.resetData();
          Navigator.push(context,
              MaterialPageRoute(builder: (_) {
                return AddTodoList();
              }));
        },
        backgroundColor: Color(0xFFf05a24),
        child: Center(
          child: Icon(Icons.add),
        ),

      ),
      body: todoViewModels.todoListModel.isEmpty ? Padding(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment(0,-0.8),
          child: Text(
            "No records",
            style: TextStyle(fontSize: 20),
          ),
        ),
      )
          : ListView.builder(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: todoViewModels.todoListModel.length,
        itemBuilder: (BuildContext context, int index) {
          final todoItem = todoViewModels.todoListModel[index];
          return TodoListRow(todoListModel: todoItem,index: index,);
        },
      ),
    );
  }
}
