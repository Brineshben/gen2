class LoginModel {
  String? status;
  String? message;
  int? statusCode;
  Data? data;

  LoginModel({this.status, this.message, this.statusCode, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? username;
  String? email;
  Null? phoneNumber;
  String? role;
  bool? isApproved;
  String? refresh;
  String? access;

  Data(
      {this.id,
        this.username,
        this.email,
        this.phoneNumber,
        this.role,
        this.isApproved,
        this.refresh,
        this.access});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    role = json['role'];
    isApproved = json['is_approved'];
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['role'] = this.role;
    data['is_approved'] = this.isApproved;
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}