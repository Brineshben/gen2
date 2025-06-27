// import 'package:get/get.dart';
// import '../../Service/ApiService.dart';
// import '../Model/CameraModel.dart';
//
// class Cameracontroller extends GetxController {
//   RxBool isLoading = false.obs;
//   RxBool isLoaded = false.obs;
//   RxBool isError = false.obs;
//
//   Rx<CameraModel?> cameradata = Rx<CameraModel?>(null);
//   RxList<Data?> CameraList  = RxList<Data?>();
//
//   Future<void> CameraDataz () async {
//     isLoading.value = true;
//     isLoaded.value = false;
//     isError.value = false;
//
//     try {
//       Map<String, dynamic> resp = await ApiServices.CameraList();
//       print("----Camera Response-----$resp");
//
//       if (resp['status'] == 200) {
//         cameradata.value = CameraModel.fromJson(resp);
//         print("Camera Data: ${cameradata.value?.data}");
//
//         CameraList .value = cameradata.value?.data ?? [];
//         isLoaded.value = true;
//       } else {
//         isError.value = true;
//       }
//     } catch (e) {
//       print("Error fetching camera data: $e");
//       isError.value = true;
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }