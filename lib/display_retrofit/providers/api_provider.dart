import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_retrofit.dart';
import '../view_models/retrofit_view_models.dart';


final usersProvider = FutureProvider<UsersModel>((ref) async {
final dio = Dio();// Provide a dio instance
final client = RestClient(dio);
return client.getUsers();
});

final retrofitViewModelsProvider = ChangeNotifierProvider<RetroFitViewModels>((ref) {
  return RetroFitViewModels();
});