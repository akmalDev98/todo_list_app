import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_list_flutter_etiqa/utils/api_response.dart';
import '../models/user_model.dart';
import '../services/api_retrofit.dart';

class RetroFitViewModels extends ChangeNotifier {

  final dio = Dio();// Provide a dio instance
  APIResponse<UsersModel>? _usersList;

  //GETTER
  APIResponse<UsersModel>? get usersList => _usersList;

  //SETTER
  setUsersList(APIResponse<UsersModel> response){
    print('setUsersList');
    _usersList = response;
    notifyListeners();
  }

  //FUNCTIONS
  Future<void> fetchUsersList() async {
    final client = RestClient(dio);
    print('fetchUsersList');
    setUsersList(APIResponse.loading());
    client.getUsers().then((value){
      setUsersList(APIResponse.completed(value));
    }).onError((error, stackTrace){
      setUsersList(APIResponse.error(error.toString()));
    });
  }

}
