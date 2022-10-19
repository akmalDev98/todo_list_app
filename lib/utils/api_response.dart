import 'constant.dart';

class APIResponse<T>{

  Status? status;
  T? data;
  String? message;

  APIResponse(this.status,this.data,this.message);

  APIResponse.loading() : status = Status.loading;
  APIResponse.completed(this.data) : status = Status.completed;
  APIResponse.error(this.message) : status = Status.error;

  @override
  String toString(){
    return "Status: $status \n Message: $message \n Data $data";
  }

}