import 'package:mobile/src/domain/entities/BaseResponse.dart';

class RegisterResponse extends BaseResponse {
  Status status;
  int statusCode;
  Result result;
  Error error;

  RegisterResponse({this.status, this.statusCode, this.result, this.error});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class Result {
  bool success;
  String message;
  Data data;

  Result({this.success, this.message, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> value = new Map<String, dynamic>();
    value['success'] = this.success;
    value['message'] = this.message;
    value['data'] = this.data;
    return value;
  }
}

class Data {
  String username;
  String password;
  int id;

  Data({this.username, this.password, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['id'] = this.id;
    return data;
  }
}
