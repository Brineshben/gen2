class CameraModel {
  int? status;
  bool? success;
  String? message;
  List<Data>? data;

  CameraModel({this.status, this.success, this.message, this.data});

  CameraModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? cameraName;
  String? rtspLink;

  Data({this.id, this.cameraName, this.rtspLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cameraName = json['camera_name'];
    rtspLink = json['rtsp_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['camera_name'] = this.cameraName;
    data['rtsp_link'] = this.rtspLink;
    return data;
  }
}