import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Service/ApiService.dart';
import '../Model/jointdataModel.dart';

class JointDatasController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  Rx<JointdatasModel?> jointData = Rx(null);


  Future<void> JointValueData() async {
    print("-----benebebn");

    isLoading.value = true;
    isLoaded.value = false;
    try {
      Map<String, dynamic> resp = await ApiServices.JointDataz();
      if (resp['status'] == 200) {
        jointData.value = JointdatasModel.fromJson(resp);
        isLoading.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isLoaded.value = false;

      ///popup
    } finally {
      isLoading.value = false;
    }
  }

}class JointDatasController2 extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  Rx<JointdatasModel?> jointData = Rx(null);


  Future<void> JointValueData2() async {
    print("-----benebebn");

    isLoading.value = true;
    isLoaded.value = false;
    try {
      Map<String, dynamic> resp = await ApiServices.JointDataz2();
      if (resp['status'] == 200) {
        print("-----status");

        jointData.value = JointdatasModel.fromJson(resp);
        print("--dsgeqrgerger---${jointData.value}");

        isLoading.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      isLoaded.value = false;

      ///popup
    } finally {
      isLoading.value = false;
    }
  }

}