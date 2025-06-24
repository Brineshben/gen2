

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Camera/Controller/CameraController.dart';
import '../JointControl/Controller/jointController.dart';

class HandleControllers {
  static createGetControllers() {
    Get.put(Cameracontroller());
    Get.put(Jointcontroller());
    Get.put(Jointcontroller2());

  }

  static deleteAllGetControllers() async {
    await Get.delete<Cameracontroller>();
    await Get.delete<Jointcontroller>();
    await Get.delete<Jointcontroller2>();

  }
}
