import 'dart:convert';

import 'apiconstant.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();

  ApiServices._internal();

  factory ApiServices() {
    return _instance;
  }
  static Future<Map<String, dynamic>> CameraList() async {
    String url = "http://192.168.1.80:7500/camera/camera/list/";
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
    const String url = "http://192.168.1.32:8001/joint/joint-status/detail/1/";
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
    const String url = "http://192.168.1.32:8001/joint/joint-status/detail/2/";
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
    required int j1,
    required int j2,
    required int j3,
    required int j4,
    required int j5,
    required int j6,
  }) async {
    // String url = "${ApiConstants.baseURL}${ApiConstants.jointControls}";
    String url = "http://192.168.1.32:8001/joint/joint-status/create/";
    print(url);
    Map apiBody = {
      "arm_number":arm,
      "j1": j1,
      "j2": j2,
      "j3": j3,
      "j4": j4,
      "j5": j5,
      "j6": j6
    };
    try {
      var request = http.Request('POST', Uri.parse(url));
      request.body = (json.encode(apiBody));
      print('Sending GET rewdgwrgfquest...${request.body }');

      // request.headers.addAll({'Content-Type': 'application/json'});
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
    // String url = "${ApiConstants.baseURL}${ApiConstants.jointControls}";
    String url = "http://192.168.1.32:8001/joint/base-control/update/";
    print(url);
    Map apiBody = {
      "value": value
    };
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
}