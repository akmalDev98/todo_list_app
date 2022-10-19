import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter_etiqa/components/add_todo_list_label.dart';
import 'package:todo_list_flutter_etiqa/todo_list/models/todo_list_models.dart';
import 'package:intl/intl.dart';
import '../../utils/constant.dart';
import '../view_models/todo_view_models.dart';

//final todoViewModelsProvider = ChangeNotifierProvider<TodoViewModels>((_) => TodoViewModels());
final todoViewModelsProvider = ChangeNotifierProvider<TodoViewModels>((ref) {
  return TodoViewModels();
});

class AddTodoList extends ConsumerWidget {
  TodoListModel? todoListModel;
  int? index;

  AddTodoList({this.todoListModel,this.index});

  bool _todoTitleValidator = false;
  // TodoListModel? getTodoListModel;
  // int? getIndex;

  //FUNCTIONS
  Future<DateTime?>  pickDate(TodoViewModels todoViewModels,int dateTimeIndicator,BuildContext context) => showDatePicker(
    context: context,
    initialDate: dateTimeIndicator == 0 ? todoViewModels.startDateTime : todoViewModels.endDateTime,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  Future<TimeOfDay?>  pickTime(TodoViewModels todoViewModels,int dateTimeIndicator,BuildContext context) => showTimePicker(
      context: context,
      initialTime: dateTimeIndicator == 0 ? TimeOfDay(hour: todoViewModels.startDateTime.hour, minute: todoViewModels.startDateTime.minute) : TimeOfDay(hour: todoViewModels.endDateTime.hour, minute: todoViewModels.endDateTime.minute)
  );

  Future pickDateTime(int dateTimeIndicator,TodoViewModels todoViewModels,BuildContext context,WidgetRef ref) async {
    DateTime? date = await pickDate(todoViewModels,dateTimeIndicator,context);
    if(date == null) return; //pressed CANCEL;

    TimeOfDay? time = await pickTime(todoViewModels,dateTimeIndicator,context);
    if(time == null) return; //pressed CANCEL;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    //todoViewModels.setNewDateTime(newDateTime,dateTimeIndicator);
    ref.read(todoViewModelsProvider).setNewDateTime(newDateTime,dateTimeIndicator);
  }

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    // print(to.difference(from).inHours);
    // print(to.difference(from).inMinutes % 60);
    return ('${to.difference(from).inHours} hrs ${to.difference(from).inMinutes % 60} min');
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final todoViewModels = ref.watch(todoViewModelsProvider);
    if(todoListModel != null){
      // todoViewModels.setCurrentTodoModel(todoListModel!);
      ref.read(todoViewModelsProvider).setCurrentTodoModel(todoListModel!);
    }
    final hoursStart = todoViewModels.startDateTime.hour.toString().padLeft(2,'0');
    final minutesStart  = todoViewModels.startDateTime.minute.toString().padLeft(2,'0');
    final hoursEnd = todoViewModels.endDateTime.hour.toString().padLeft(2,'0');
    final minutesEnd  = todoViewModels.endDateTime.minute.toString().padLeft(2,'0');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Add New To-Do List",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: primaryColor,
          centerTitle: false,
          automaticallyImplyLeading: true,
        ),
        bottomNavigationBar: ElevatedButton(
          child: Text(
            todoListModel != null ? 'Edit' : 'Create',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(screenWidth, 70),
            primary: Colors.black,
          ),
          onPressed: () async {
            final timeLeft = daysBetween(todoViewModels.startDateTime, todoViewModels.endDateTime);
            //print(timeLeft.toString());

            if(todoViewModels.todoTitle.text == "") {
              _todoTitleValidator = true;
            } else{
              _todoTitleValidator = false;
              final newTodoListModel = TodoListModel(
                title: todoViewModels.todoTitle.text,
                startDate: todoViewModels.startDateTime,
                endDate: todoViewModels.endDateTime,
                timeLeft: timeLeft,
                status: false,
              );

              // todoListModel != null ? todoViewModels.setTodoListItem(newTodoListModel, index!) : todoViewModels.setTodoListModel(newTodoListModel);
              todoListModel != null ? ref.read(todoViewModelsProvider).setTodoListItem(newTodoListModel, index!) : ref.read(todoViewModelsProvider).setTodoListModel(newTodoListModel);
              Navigator.of(context).pop();
            }

          },
        ),
        body: Align(
          alignment: Alignment(0,0),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 10,top: 20),
              height: screenHeight*0.8,
              width: screenWidth*0.85,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddTodoListLabel(label: "To-Do Title"),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: ref.watch(todoViewModelsProvider.notifier).todoTitle,
                    maxLines: 5,
                    //maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'Please key in your To Do title here',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.grey, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2),
                      ),
                    ),
                    // ignore: missing_return
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    //onChanged: (value) => ref.read(todoViewModelsProvider).setTodoTitle(value),
                  ),
                  _todoTitleValidator
                      ? Padding(
                    padding:
                    const EdgeInsets.only(
                        top: 5.0),
                    child: Text(
                      "Required",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight:
                          FontWeight.w400),
                    ),
                  )
                      : SizedBox(),
                  SizedBox(height: 20,),
                  AddTodoListLabel(label: "Start Date"),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      await pickDateTime(0,todoViewModels,context,ref); // 0-start
                    },
                    child: Text('${todoViewModels.startDateTime.day}/${todoViewModels.startDateTime.month}/${todoViewModels.startDateTime.year} $hoursStart:$minutesStart',style: TextStyle(color: Colors.white,fontSize: 16),),
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.white,
                      elevation: 2.0,
                      side: BorderSide(color: Colors.grey),
                      minimumSize: Size(200,60),
                    ),
                  ),
                  SizedBox(height: 20,),
                  AddTodoListLabel(label: "Estimated End Date"),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      await pickDateTime(1,todoViewModels,context,ref); // 1-end
                    },
                    child: Text('${todoViewModels.endDateTime.day}/${todoViewModels.endDateTime.month}/${todoViewModels.endDateTime.year} $hoursEnd:$minutesEnd',style: TextStyle(color: Colors.white,fontSize: 16),),
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: Colors.white,
                      elevation: 2.0,
                      side: BorderSide(color: Colors.grey),
                      minimumSize: Size(200,60),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}