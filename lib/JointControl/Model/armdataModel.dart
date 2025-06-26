class ArmdataModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;

  ArmdataModel({this.status, this.statusCode, this.message, this.data});

  ArmdataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
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
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? ctrlMode;
  String? armStatus;
  String? modeFeed;
  String? teachMode;
  String? motionStatus;
  String? trajectoryNum;
  String? armNumber;

  Data(
      {this.ctrlMode,
        this.armStatus,
        this.modeFeed,
        this.teachMode,
        this.motionStatus,
        this.trajectoryNum,
        this.armNumber});

  Data.fromJson(Map<String, dynamic> json) {
    ctrlMode = json['ctrl_mode'];
    armStatus = json['arm_status'];
    modeFeed = json['mode_feed'];
    teachMode = json['teach_mode'];
    motionStatus = json['motion_status'];
    trajectoryNum = json['trajectory_num'];
    armNumber = json['arm_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ctrl_mode'] = this.ctrlMode;
    data['arm_status'] = this.armStatus;
    data['mode_feed'] = this.modeFeed;
    data['teach_mode'] = this.teachMode;
    data['motion_status'] = this.motionStatus;
    data['trajectory_num'] = this.trajectoryNum;
    data['arm_number'] = this.armNumber;
    return data;
  }
}