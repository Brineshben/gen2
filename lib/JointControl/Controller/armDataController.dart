import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Service/ApiService.dart';
import '../Model/armdataModel.dart';

class Armcontroller extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;

  Rx<ArmdataModel?> Armdata = Rx(null);

  RxList<Data> armList = RxList();

  Future<void> jointDataz() async {
    isLoading.value = true;
    isLoaded.value = false;
    isError.value = false;

    try {
      Map<String, dynamic> resp = await ApiServices.ArmService();
      print("--jointdata----$resp");

      if (resp['status'] == 'success') {
        Armdata.value = ArmdataModel.fromJson(resp);

        // Extract joint integers and assign
        armList.value = Armdata.value?.data ?? [];

        isLoaded.value = true;
      } else {
        isError.value = true;
      }
    } catch (e) {
      print("Error fetching joint data: $e");
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}