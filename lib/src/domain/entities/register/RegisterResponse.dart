import 'package:mobile/src/domain/entities/BaseResponse.dart';

class RegisterResponse extends BaseResponse {
  Result result;
  int statusCode;
  Status status;
  Error error;

  RegisterResponse({this.result, this.statusCode, this.status});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['statusCode'] = this.statusCode;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Result {
  String email;
  String fullName;
  String type;
  String status;
  String gender;
  String phone;
  String address;
  String job;
  String birthday;
  String identity;
  String note;
  int ownerId;
  int id;
  String createdAt;
  String updatedAt;

  Result(
      {this.email,
      this.fullName,
      this.type,
      this.status,
      this.gender,
      this.phone,
      this.address,
      this.job,
      this.birthday,
      this.identity,
      this.note,
      this.ownerId,
      this.id,
      this.createdAt,
      this.updatedAt});

  Result.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullName = json['fullName'];
    type = json['type'];
    status = json['status'];
    gender = json['gender'];
    phone = json['phone'];
    address = json['address'];
    job = json['job'];
    birthday = json['birthday'];
    identity = json['identity'];
    note = json['note'];
    ownerId = json['ownerId'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['type'] = this.type;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['job'] = this.job;
    data['birthday'] = this.birthday;
    data['identity'] = this.identity;
    data['note'] = this.note;
    data['ownerId'] = this.ownerId;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

// class Result {
//   bool success;
//   String message;
//   Data data;

//   Result({this.success, this.message, this.data});

//   Result.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> value = new Map<String, dynamic>();
//     value['success'] = this.success;
//     value['message'] = this.message;
//     value['data'] = this.data;
//     return value;
//   }
// }

// class Data {
//   String username;
//   String password;
//   int id;

//   Data({this.username, this.password, this.id});

//   Data.fromJson(Map<String, dynamic> json) {
//     username = json['username'];
//     password = json['password'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['username'] = this.username;
//     data['password'] = this.password;
//     data['id'] = this.id;
//     return data;
//   }
// }
