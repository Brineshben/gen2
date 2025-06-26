class ApiConstants {
  static final ApiConstants _instance = ApiConstants._internal();

  ApiConstants._internal();

  factory ApiConstants() {
    return _instance;
  }

  ///BaseURL
  static String baseURL = "http://192.168.1.52:8000";

  static String camera = "/camera/camera/list/";
  static String jointControls = "/joint/joint-status/create/";
  static String jointList = "/joint/joint-status/detail/";
  //--------------------------------------------------------

  static String createQa = "/prompt/ask/question/";
  static String qAList = "/prompt/prompt/history/";
}
