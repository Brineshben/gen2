class JointdatasModel {
  int? status;
  bool? success;
  String? message;
  Data? data;

  JointdatasModel({this.status, this.success, this.message, this.data});

  JointdatasModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? x;
  String? y;
  String? z;
  String? rx;
  String? ry;
  String? rz;
  String? armNumber;

  Data(
      {this.id,
        this.x,
        this.y,
        this.z,
        this.rx,
        this.ry,
        this.rz,
        this.armNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    x = json['x'];
    y = json['y'];
    z = json['z'];
    rx = json['Rx'];
    ry = json['Ry'];
    rz = json['Rz'];
    armNumber = json['arm_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['x'] = this.x;
    data['y'] = this.y;
    data['z'] = this.z;
    data['Rx'] = this.rx;
    data['Ry'] = this.ry;
    data['Rz'] = this.rz;
    data['arm_number'] = this.armNumber;
    return data;
  }
}