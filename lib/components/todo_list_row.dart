import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_flutter_etiqa/components/todo_list_row_checkbox.dart';
import 'package:todo_list_flutter_etiqa/components/todo_list_row_date.dart';
import 'package:todo_list_flutter_etiqa/todo_list/models/todo_list_models.dart';
import 'package:todo_list_flutter_etiqa/utils/constant.dart';

import '../todo_list/views/add_todo_list.dart';

class TodoListRow extends StatelessWidget {
  TodoListModel todoListModel;
  int index;

  TodoListRow({required this.todoListModel,required this.index});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTodoList(todoListModel: todoListModel,index: index,)));
      },
      child: Align(
        alignment: Alignment(0,-0.8),
        child: Container(
//padding: EdgeInsets.only(left: 20,right: 10),
          margin: EdgeInsets.only(top: 30),
          height: 180,
          width: screenWidth*0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,right: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(todoListModel.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                  )),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: 20,right: 10),
                  child: Row(
                    children: [
                      TodoListRowDate(
                        "Start Date:",
                        DateFormat('dd MMM yyyy').format(todoListModel.startDate!),
                      ),
                      TodoListRowDate(
                        "End Date:",
                        DateFormat('dd MMM yyyy').format(todoListModel.endDate!),
                      ),
                      TodoListRowDate(
                        "Time Left:",
                        todoListModel.timeLeft,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 20,right: 10),
                  decoration: BoxDecoration(
                    color: todoListModel.status ? primaryColor.withOpacity(0.5) : Color(0xFFe8e3d1),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Status: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          TextSpan(
                              text: todoListModel.status ? 'Complete' : 'Incomplete',
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,)),
                        ]),
                      ),
                      Spacer(),
                      Text("Tick if completed",),
                      TodoListRowCheckBox(index: index,),
                    ],
                  ),
                ),
              )],
          ),
        ),
      ),
    );
  }
}
