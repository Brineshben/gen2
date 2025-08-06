import 'dart:convert';

import '../Chat_Page/qalistmodel.dart';
import 'apiconstant.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();

  ApiServices._internal();

  factory ApiServices() {
    return _instance;
  }
  ///login
  static Future<Map<String, dynamic>> userLogin({
    required String userName,
    required String psw,
  }) async {
    String url = "${ApiConstants.baseURL}${ApiConstants.login}";
    print(url);
    Map apiBody = {
      "username": userName,
      "password": psw,
    };
    // try {
    var request = http.Request('POST', Uri.parse(url));
    request.body = (json.encode(apiBody));
    request.headers.addAll({'Content-Type': 'application/json'});
    print('Api body---------------------->${request.body}');
    http.StreamedResponse response = await request.send();
    print('Api bodybenenen---------------------->${response}');

    var respString = await response.stream.bytesToString();
    print('Api body---------------------->${json.decode(respString)}');
    return json.decode(respString);

    // } catch (e) {
    //   throw Exception("Service Error");
    // }
  }

  static Future<Map<String, dynamic>> CameraList() async {
    String url = "${ApiConstants.baseURL}${ApiConstants.cameraList}";
    // String url = "http://192.168.11.202:7500/camera/camera/list/";
    print("Doctor List---$url");

    try {
      print("Sending request to $url");
      var request = http.Request('GET', Uri.parse(url));
      http.StreamedResponse response = await request.send();
      print('Patient Queue Response------->${response}');

      var respString = await response.stream.bytesToString();
      return json.decode(respString);
    } catch (e) {
      print("Error during request: $e"); // Add this
      throw Exception("Service Error in CameraList");
    }
  }

  ///joint LIST
  static Future<Map<String, dynamic>> fetchJointList() async {
    String url = "${ApiConstants.baseURL}${ApiConstants.jointList}";

    // const String url = "http://192.168.11.202:7500/joint/joint-status/detail/1/";
    print("Fetching Joint List from: $url");

    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll({'Content-Type': 'application/json'});

      print('Sending GET request...');

      http.StreamedResponse response = await request.send();

      print('Response status: ${response.statusCode}');

      String responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        throw Exception('Failed to fetch joint list: ${response.statusCode}');
      }
    } catch (e) {
      print("Error during Joint List fetch: $e");
      throw Exception("Service Error while fetching Joint List: $e");
    }
  }

  ///joint LIST
  static Future<Map<String, dynamic>> fetchJointList2() async {
    String url = "${ApiConstants.baseURL}${ApiConstants.jointList2}";
    print("Fetching Joint List from: $url");

    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll({'Content-Type': 'application/json'});

      print('Sending GET request...');

      http.StreamedResponse response = await request.send();

      print('Response status: ${response.statusCode}');

      String responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        throw Exception('Failed to fetch joint list: ${response.statusCode}');
      }
    } catch (e) {
      print("Error during Joint List fetch: $e");
      throw Exception("Service Error while fetching Joint List: $e");
    }
  }

  // static Future<Map<String, dynamic>> JointList2() async {
  //   // String url = "${ApiConstants.baseURL}${ApiConstants.jointList}$id/";
  //   String url = "http://192.168.1.32:8000/joint/joint-status/detail/2/";
  //   print("DoctoSADFVDSVr List---$url");
  //
  //   try {
  //     print("Sending request to $url");
  //     var request = http.Request('GET', Uri.parse(url));
  //     http.StreamedResponse response = await request.send();
  //     print('Patient xsavasdfbvdfbef Response------->${response}');
  //
  //     var respString = await response.stream.bytesToString();
  //      return json.decode(respString);
  //
  //
  //   } catch (e) {
  //     throw Exception("Service Errordwsgeger Login Api$e");
  //   }
  // }

  static Future<Map<String, dynamic>> JointControls({
    required String arm,
    required List<int> joints,
  }) async {
    String url = "${ApiConstants.baseURL}${ApiConstants.jointCreate}";
    // String url = "http://192.168.11.202:7500/joint/joint-status/create/";
    print(url);

    Map<String, dynamic> apiBody = {
      "arm_number": arm,

      "joints": joints,
      "status": true
    };
    try {
      var request = http.Request('POST', Uri.parse(url));
      request.body = (json.encode(apiBody));
      print('Sending GET rewdgwrgfquest...${request.body}');

      request.headers.addAll({'Content-Type': 'application/json'});
      http.StreamedResponse response = await request.send();
      print('joint control response------------->${response}');

      var respString = await response.stream.bytesToString();
      return json.decode(respString);
    } catch (e) {
      throw Exception("Service Error Login Api");
    }
  }

  static Future<Map<String, dynamic>> JoystickService({
    required String value,
  }) async {
    String url = "${ApiConstants.baseURL}${ApiConstants.joystick}";
    // String url = "http://192.168.11.202:7500/joint/base-control/update/";
    print(url);
    Map apiBody = {"value": value};
    try {
      var request = http.Request('POST', Uri.parse(url));
      request.body = (json.encode(apiBody));
      request.headers.addAll({'Content-Type': 'application/json'});
      http.StreamedResponse response = await request.send();
      print('joint control response------------->${response}');

      var respString = await response.stream.bytesToString();
      return json.decode(respString);
    } catch (e) {
      throw Exception("Service Error Login Api");
    }
  }

  static Future<Map<String, dynamic>> JointDataz(// required String value,

      ) async {
    String url = "${ApiConstants.baseURL}${ApiConstants.jointValue}";

    // String url = "http://192.168.11.202:7500/camera/position/detail/1/";
    // print(url);
    // Map apiBody = {
    //   "value": value
    // };
    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll({'Content-Type': 'application/json'});
      http.StreamedResponse response = await request.send();
      print('joint control response------------->${response}');

      var respString = await response.stream.bytesToString();
      return json.decode(respString);
    } catch (e) {
      throw Exception("Service Error Login Api");
    }
  }

  static Future<Map<String, dynamic>> JointDataz2() async {
    String url = "${ApiConstants.baseURL}${ApiConstants.jointValue2}";
    print(url);
    // Map apiBody = {
    //   "value": value
    // };
    try {
      var request = http.Request('GET', Uri.parse(url));
      // request.body = (json.encode(apiBody));
      request.headers.addAll({'Content-Type': 'application/json'});
      http.StreamedResponse response = await request.send();
      print('joint control response------------->${response}');

      var respString = await response.stream.bytesToString();
      return json.decode(respString);
    } catch (e) {
      throw Exception("Service Error Login Api");
    }
  }
  static Future<Map<String, dynamic>> ArmService() async {
    String url = "${ApiConstants.baseURL}${ApiConstants.armService}";
    // print(url);
    // Map apiBody = {
    //   "value": value
    // };
    try {
      var request = http.Request('GET', Uri.parse(url));
      // request.body = (json.encode(apiBody));
      request.headers.addAll({'Content-Type': 'application/json'});
      http.StreamedResponse response = await request.send();
      print('ArmService response------------->${response}');

      var respString = await response.stream.bytesToString();
      return json.decode(respString);
    } catch (e) {
      throw Exception("Service Error Login Api");
    }
  }
  static Future<Map<String, dynamic>> createQA(
      {required String question}) async {
    String url = "${ApiConstants.baseURL}${ApiConstants.createQa}";
    try {
      var request = http.Request('POST', Uri.parse(url));
      Map apiBody = {"question": question};

      request.headers.addAll({'Content-Type': 'application/json'});
      request.body = (json.encode(apiBody));

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');
      if (response.statusCode == 200) {
        return json.decode(responseBody);
      } else {
        throw Exception('Failed to fetch joint list: ${response.statusCode}');
      }
    } catch (e) {
      print("Error during Joint List fetch: $e");
      throw Exception("Service Error while fetching Joint List: $e");
    }
  }

// get list of Q&A
  static Future<QAListModel> getQAList() async {
    String url = "${ApiConstants.baseURL}${ApiConstants.qAList}";
    try {
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll({'Content-Type': 'application/json'});
      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(responseBody);
        return QAListModel.fromJson(jsonResponse);
      } else {
        throw Exception(
            'Failed to fetch question list: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching QA List: $e");
      throw Exception("Error fetching QA List: $e");
    }
  }
}
