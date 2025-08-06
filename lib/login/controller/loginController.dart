import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../HomePage/HomePage.dart';
import '../../Service/ApiService.dart';
import '../../Service/popups.dart';
import '../../Service/sharedPrefernce.dart';
import '../model/loginModel.dart';

class UserAuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<LoginModel?> loginData = Rx<LoginModel?>(null);
  Rx<Data?> userdata = Rx<Data?>(null);

  /// Reset loading and error state
  void resetStatus() {
    isLoading.value = false;
  }

  /// Login Method
  Future<void> login({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;

    try {
      final resp = await ApiServices.userLogin(userName: username, psw: password);
      print("Login API Response: $resp");

      if (resp['status'] == "ok") {
        final loginApi = LoginModel.fromJson(resp);

        // Save login data
        loginData.value = loginApi;
        await SharedPrefs().setLoginData(loginApi);

        // Log user ID if available
        print("User ID: ${loginApi.data?.id}");

        // Navigate to main screen
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, animation, secondaryAnimation) => FourSectionScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      } else {
        // Show error popup
        ProductAppPopUps.submit(
          title: "Failed",
          message: resp['message'] ?? 'Something went wrong.',
          actionName: "Try again",
          iconData: Icons.error_outline,
          iconColor: Colors.red,
        );
      }
    } catch (e) {
      // Handle exception
      print("Login Exception: $e");
      Get.snackbar(
        'Failed',
        'API error occurred during login.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error, color: Colors.white),
      );
    } finally {
      resetStatus();
    }
  }

  /// Restore saved user session
  Future<void> getUserLoginSaved(LoginModel loginApi) async {
    loginData.value = loginApi;
  }
}
