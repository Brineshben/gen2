class JointModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;

  JointModel({this.status, this.statusCode, this.message, this.data});

  JointModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? armNumber;
  List<int>? joints;

  Data({this.armNumber, this.joints});

  Data.fromJson(Map<String, dynamic> json) {
    armNumber = json['arm_number'];
    joints = json['joints'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arm_number'] = this.armNumber;
    data['joints'] = this.joints;
    return data;
  }
}