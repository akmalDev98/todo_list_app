import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter_etiqa/display_retrofit/views/retrofit_screen.dart';
import 'package:todo_list_flutter_etiqa/todo_list/view_models/todo_view_models.dart';
import 'package:todo_list_flutter_etiqa/utils/constant.dart';

import '../../components/todo_list_row.dart';
import 'add_todo_list.dart';


class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final todoViewModels = ref.watch(todoViewModelsProvider).todoListModel;

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
        actions: [
          GestureDetector(
              onTap: (){
                  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RetrofitScreen(),
                ),
    );},
              child: Row(
                children: [
                  Text("Retrofit Screen",style: TextStyle(fontSize: 18),),
                  Icon(Icons.arrow_circle_right_outlined,size: 45,),
                ],
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(todoViewModelsProvider).resetData();
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
      body: todoViewModels.isEmpty ? Padding(
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
        itemCount: todoViewModels.length,
        itemBuilder: (BuildContext context, int index) {
          final todoItem = todoViewModels[index];
         return TodoListRow(todoListModel: todoItem,index: index,);
        },
      ),
    );
  }
}
