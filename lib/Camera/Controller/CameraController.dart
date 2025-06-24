
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../Service/ApiService.dart';
import '../Model/CameraModel.dart';

class Cameracontroller extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;
  Rx<CameraModel?> cameradata = Rx(null);

  RxList<Data?> CameraList = RxList();

  Future<void> CameraDataz () async {
    isLoading.value = true;
    isLoaded.value = false;
    try {
      Map<String, dynamic> resp = await ApiServices.CameraList();
      print("----talkToHuman-----$resp");
      if (resp['status'] == 200) {
        cameradata.value = CameraModel.fromJson(resp);
        print("patient list${cameradata.value?.data}");
        CameraList.value = cameradata.value?.data ?? [];
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
