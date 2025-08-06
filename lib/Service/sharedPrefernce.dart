import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

import '../login/model/loginModel.dart';

class SharedPrefs {
  final _getIt = GetIt.instance;
  SharedPreferences? _prefs;

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception("SharedPreferences has not been initialized.");
    }
    return _prefs!;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPrefs>(this);
  }

  Future<bool> setLoginData(LoginModel loginApi) async {
    Map<String, dynamic> api = loginApi.toJson();
    String encodedData = json.encode(api);
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    return await prefs.setString("loginData", encodedData);
  }

  Future<LoginModel?> getLoginData() async {
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    String? res = prefs.getString("loginData");
    if (res != null) {
      Map<String, dynamic> api = json.decode(res);
      LoginModel loginApiModel = LoginModel.fromJson(api);
      return loginApiModel;
    }
    return null;
  }

  Future<bool> removeLoginData() async {
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    bool done = await prefs.remove("loginData");
    return done;
  }
}