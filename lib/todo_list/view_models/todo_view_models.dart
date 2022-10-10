 import 'package:flutter/material.dart';

import '../models/todo_list_models.dart';

class TodoViewModels extends ChangeNotifier {
  List<TodoListModel> _todoListModel = [];

  List<TodoListModel> get todoListModel => _todoListModel;

  setTodoListModel(TodoListModel todoListModel){
    _todoListModel.add(todoListModel);
    notifyListeners();
  }

  setTodoListCompleted(bool isCompleted,int index){
    _todoListModel[index].status = isCompleted;
    notifyListeners();
  }

  setTodoListItem(TodoListModel todoListModel,int index){
    _todoListModel[index] = todoListModel;
    notifyListeners();
  }

  // setTodoListModel(List<TodoListModel> todoListModel){
  //   _todoListModel = todoListModel;
  // }


}