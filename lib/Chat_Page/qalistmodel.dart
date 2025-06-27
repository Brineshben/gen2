class QAListModel {
  int? status;
  String? message;
  List<Data>? data;

  QAListModel({this.status, this.message, this.data});

  QAListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? sessionId;
  String? question;
  String? answer;
  bool? isAnswered;
  String? createdAt;
  String? answeredAt;
  bool? status;

  Data(
      {this.id,
        this.sessionId,
        this.question,
        this.answer,
        this.isAnswered,
        this.createdAt,
        this.answeredAt,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    question = json['question'];
    answer = json['answer'];
    isAnswered = json['is_answered'];
    createdAt = json['created_at'];
    answeredAt = json['answered_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['is_answered'] = this.isAnswered;
    data['created_at'] = this.createdAt;
    data['answered_at'] = this.answeredAt;
    data['status'] = this.status;
    return data;
  }
}