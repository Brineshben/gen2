class ApiConstants {
  static final ApiConstants _instance = ApiConstants._internal();

  ApiConstants._internal();

  factory ApiConstants() {
    return _instance;
  }

  ///BaseURL
  // static String baseURL = "http://192.168.11.202:7500";
  static String baseURL = "http://192.168.1.80:7500";

  static String cameraList ="/camera/camera/list/";
  static String jointCreate ="/joint/joint-status/create/";
  static String joystick ="/joint/base-control/update/";
  static String jointList ="/joint/joint-status/detail/1/";
  static String jointList2 ="/joint/joint-status/detail/2/";
  static String jointValue ="/camera/position/detail/1/";
  static String jointValue2 ="/camera/position/detail/2/";
  static String armService ="/arm/arm/list/";
  static String createQa = "/prompt/ask/question/";
  static String qAList = "/prompt/prompt/history/";

}