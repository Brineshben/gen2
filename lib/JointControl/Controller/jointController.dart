import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../Service/ApiService.dart';
import '../Model/jointModel.dart';
class Jointcontroller extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;

  Rx<JointModel?> jointdata = Rx(null);

  // Updated to hold joint values directly
  RxList<int> jointList = <int>[].obs;

  // Optional: if you're using Slider (which needs double)
  RxList<double> valueList = <double>[].obs;
  final List<double> minValues = [-154, 0, -175, -106, -75, -100];
  final List<double> maxValues = [154, 195, 0, 106, 75, 100];
  Future<void> jointDataz() async {
    isLoading.value = true;
    isLoaded.value = false;
    isError.value = false;

    try {
      Map<String, dynamic> resp = await ApiServices.fetchJointList();
      print("--jointdata----$resp");

      if (resp['status'] == 'success') {
        jointdata.value = JointModel.fromJson(resp);

        // Extract joint integers and assign
        jointList.value = jointdata.value?.data?.joints ?? [];

        // Optional: for Slider (Slider widget uses double values)
        valueList.value = jointList.map((e) => e.toDouble()).toList();

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

class Jointcontroller2 extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isError = false.obs;

  Rx<JointModel?> jointdata = Rx(null);

  // Updated to hold joint values directly
  RxList<int> jointList = <int>[].obs;

  // Optional: if you're using Slider (which needs double)
  RxList<double> valueList = <double>[].obs;
  final List<double> minValues = [-154, 0, -175, -106, -75, -100];
  final List<double> maxValues = [154, 195, 0, 106, 75, 100];
  Future<void> jointDatazz() async {
    isLoading.value = true;
    isLoaded.value = false;
    isError.value = false;

    try {
      Map<String, dynamic> resp = await ApiServices.fetchJointList2();
      print("--jointdata----$resp");

      if (resp['status'] == 'success') {
        jointdata.value = JointModel.fromJson(resp);

        // Extract joint integers and assign
        jointList.value = jointdata.value?.data?.joints ?? [];

        // Optional: for Slider (Slider widget uses double values)
        valueList.value = jointList.map((e) => e.toDouble()).toList();

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





// class Jointcontroller2 extends GetxController {
//   RxBool isLoading = false.obs;
//   RxBool isLoaded = false.obs;
//   RxBool isError = false.obs;
//   Rx<JointModel?> jointdata = Rx(null);
//   Rx<Data?> jointList = Rx(null);
//   // RxList<double> valueList = <double>[].obs;
//
//
//   Future<void> jointDataz2() async {
//     isLoading.value = true;
//     isLoaded.value = false;
//     try {
//       Map<String, dynamic> resp = await ApiServices.JointList();
//       print("--jointdata----$resp");
//       if (resp['status'] == 'success') {
//         jointdata.value = JointModel.fromJson(resp);
//         jointList.value = jointdata.value?.data;
//         // valueList.value = [
//         //   jointList.value?.j1?.toDouble() ?? 0.0,
//         //   jointList.value?.j2?.toDouble() ?? 0.0,
//         //   jointList.value?.j3?.toDouble() ?? 0.0,
//         //   jointList.value?.j4?.toDouble() ?? 0.0,
//         //   jointList.value?.j5?.toDouble() ?? 0.0,
//         //   jointList.value?.j6?.toDouble() ?? 0.0
//         // ];
//         isLoading.value = true;
//       } else {
//         isError.value = true;
//       }
//     } catch (e) {
//       isLoaded.value = false;
//       print("Errodewsgerghwer $e");
//
//       ///popup
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
// }