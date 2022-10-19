import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import '../models/user_model.dart';

part 'api_retrofit.g.dart';

@RestApi(baseUrl: 'https://reqres.in/api')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/users?page=2")
  Future<UsersModel> getUsers();
}

//
// @RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
// abstract class RestClient {
//   factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
//
//   @GET("/tasks")
//   Future<List<Task>> getTasks();
// }
//
// @JsonSerializable()
// class Task {
//   String? id;
//   String? name;
//   String? avatar;
//   String? createdAt;
//
//   Task({this.id, this.name, this.avatar, this.createdAt});
//
//   factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
//   Map<String, dynamic> toJson() => _$TaskToJson(this);
// }

@JsonSerializable()
class UsersModel {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Datum>? data;
  Support? support;

  UsersModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => _$UsersModelFromJson(json);
  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}

@JsonSerializable()
class Datum {
  int? id;
  String? email;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  String? avatar;

  Datum({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Support {
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  factory Support.fromJson(Map<String, dynamic> json) => _$SupportFromJson(json);
  Map<String, dynamic> toJson() => _$SupportToJson(this);
}


