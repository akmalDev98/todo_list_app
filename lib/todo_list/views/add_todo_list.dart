import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_flutter_etiqa/components/add_todo_list_label.dart';
import 'package:todo_list_flutter_etiqa/todo_list/models/todo_list_models.dart';
import 'package:intl/intl.dart';
import '../../utils/constant.dart';
import '../view_models/todo_view_models.dart';

class AddTodoList extends StatefulWidget {
  TodoListModel? todoListModel;
  int? index;

  AddTodoList({this.todoListModel,this.index});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {

  TextEditingController _todoTitle = TextEditingController();
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();
  bool _todoTitleValidator = false;
  TodoListModel? todoListModel;
  int? index;

  //FUNCTIONS
  Future<DateTime?>  pickDate() => showDatePicker(
      context: context,
      initialDate: _startDateTime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
  );

  Future<TimeOfDay?>  pickTime() => showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: _startDateTime.hour, minute: _startDateTime.minute),
  );

  Future pickDateTime(int dateTimeIndicator) async {
    DateTime? date = await pickDate();
    if(date == null) return; //pressed CANCEL;

    TimeOfDay? time = await pickTime();
    if(time == null) return; //pressed CANCEL;

    final newDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    dateTimeIndicator == 0 ? setState(() => _startDateTime = newDateTime) : setState(() => _endDateTime = newDateTime);
  }

  String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
    to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
    // print(to.difference(from).inHours);
    // print(to.difference(from).inMinutes % 60);
    return ('${to.difference(from).inHours} hrs ${to.difference(from).inMinutes % 60} min');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoListModel = widget.todoListModel;
    index = widget.index;
    if(todoListModel != null){
      _todoTitle.text = todoListModel!.title;
      _startDateTime = todoListModel!.startDate!;
      _endDateTime = todoListModel!.endDate!;
    }
  }



  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TodoViewModels todoViewModels = context.watch<TodoViewModels>();
    final hoursStart = _startDateTime.hour.toString().padLeft(2,'0');
    final minutesStart  = _startDateTime.minute.toString().padLeft(2,'0');
    final hoursEnd = _startDateTime.hour.toString().padLeft(2,'0');
    final minutesEnd  = _startDateTime.minute.toString().padLeft(2,'0');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Add New To-Do List",
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
            final timeLeft = daysBetween(_startDateTime, _endDateTime);
            //print(timeLeft.toString());

            if(_todoTitle.text == "") {
              _todoTitleValidator = true;
              setState((){});
            } else{
              _todoTitleValidator = false;
              setState((){});
              final newTodoListModel = TodoListModel(
                title: _todoTitle.text,
                startDate: _startDateTime,
                endDate: _endDateTime,
                timeLeft: timeLeft,
                status: false,
              );

              todoListModel != null ? todoViewModels.setTodoListItem(newTodoListModel, index!) : todoViewModels.setTodoListModel(newTodoListModel);
              //todoViewModels.setTodoListModel(newTodoListModel);
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
                controller: _todoTitle,
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
                onSaved: (value) {
                  _todoTitle.text = value!;
                },
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
                      await pickDateTime(0); // 0-start
                    },
                    child: Text('${_startDateTime.day}/${_startDateTime.month}/${_startDateTime.year} $hoursStart:$minutesStart',style: TextStyle(color: Colors.white,fontSize: 16),),
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
                      await pickDateTime(1); // 1-end
                    },
                    child: Text('${_endDateTime.day}/${_endDateTime.month}/${_endDateTime.year} $hoursEnd:$minutesEnd',style: TextStyle(color: Colors.white,fontSize: 16),),
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
