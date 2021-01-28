import 'package:mobile/src/domain/entities/BaseResponse.dart';

class RegisterResponse extends BaseResponse {
  Status status;
  Result result;
  Error error;

  RegisterResponse({this.status, this.result, this.error});

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
    if (this.status != null) data['status'] = this.status.toJson();
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
  int isSuccess = 0;

  Result({this.isSuccess});

  Result.fromJson(Map<String, dynamic> json) {
    isSuccess = json['is_success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_success'] = this.isSuccess;
    return data;
  }
}
