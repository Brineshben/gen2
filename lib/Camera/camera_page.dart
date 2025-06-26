// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:get/get.dart';

// import '../Chat_Page/chatpage.dart';
// import 'Controller/CameraController.dart';
// import 'camerafullscreen.dart';

// class CameraSection extends StatefulWidget {
//   const CameraSection({super.key});

//   @override
//   State<CameraSection> createState() => _CameraSectionState();
// }

// class _CameraSectionState extends State<CameraSection> {
//   @override
//   void initState() {
//     super.initState();
//     Get.find<Cameracontroller>().CameraDataz(); // Load camera data
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         color: Colors.black,
//         padding: const EdgeInsets.all(2),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text("LIVE CAMERA",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//             GetX<Cameracontroller>(
//               builder: (controller) {
//                 if (controller.isLoading.value) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                   );
//                 }
//                 if (controller.CameraList.isEmpty) {
//                   return const Center(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: 30),
//                       child: Text(
//                         "No Data form the api",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 2,
//                       crossAxisSpacing: 2,
//                       childAspectRatio: 16 / 9,
//                     ),
//                     itemCount: controller.CameraList.length,
//                     itemBuilder: (context, index) {
//                       final cam = controller.CameraList[index];
//                       final VlcPlayerController vlcController = VlcPlayerController.network(
//                         cam?.rtspLink ?? "",
//                         hwAcc: HwAcc.auto,
//                         autoPlay: true,
//                         options: VlcPlayerOptions(),
//                       );

//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => CameraFullScreenPage(rtspUrl: cam?.rtspLink ?? ""),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           color: Colors.black,
//                           child: VlcPlayer(
//                             controller: vlcController,
//                             aspectRatio: 16 / 9,
//                             placeholder: const Center(child: CircularProgressIndicator()),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
