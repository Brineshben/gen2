// import 'package:flutter/material.dart';
// import 'package:flutter_vlc_player/flutter_vlc_player.dart';
// import 'package:get/get.dart';
//
// import '../Chat_Page/chatpage.dart';
// import 'Controller/CameraController.dart';
// import 'camerafullscreen.dart';
//
// class CameraSection extends StatefulWidget {
//   const CameraSection({super.key});
//
//   @override
//   State<CameraSection> createState() => _CameraSectionState();
// }
//
// class _CameraSectionState extends State<CameraSection> {
//   @override
//   void initState() {
//     super.initState();
//     Get.find<Cameracontroller>().CameraDataz(); // Load camera data
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       padding: const EdgeInsets.all(2),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 5),
//                 child: Text("LIVE CAMERA",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//           GetX<Cameracontroller>(
//             builder: (controller) {
//               if (controller.isLoading.value) {
//                 return const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.blue,
//                   ),
//                 );
//               }
//               if (controller.CameraList.isEmpty) {
//                 return const Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 30),
//                     child: Text(
//                       "No Data form the api",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Expanded(
//                   child: GridView.builder(
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
//
//                       return GestureDetector(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               final VlcPlayerController popupController = VlcPlayerController.network(
//                                 cam?.rtspLink ?? "",
//                                 hwAcc: HwAcc.auto,
//                                 autoPlay: true,
//                               );
//
//                               return Dialog(
//                                 backgroundColor: Colors.black,
//                                 insetPadding: EdgeInsets.zero,
//                                 child: StatefulBuilder(
//                                   builder: (context, setState) {
//                                     bool isPlaying = false;
//
//                                     popupController.addListener(() {
//                                       final newState = popupController.value.isPlaying;
//                                       if (newState != isPlaying) {
//                                         setState(() {
//                                           isPlaying = newState;
//                                         });
//                                       }
//                                     });
//
//                                     return Stack(
//                                       children: [
//                                         Center(
//                                           child: AspectRatio(
//                                             aspectRatio: 16 / 9,
//                                             child: VlcPlayer(
//                                               controller: popupController,
//                                               aspectRatio: 16 / 9,
//                                               placeholder: const Center(
//                                                 child: CircularProgressIndicator(
//                                                   color: Colors. green,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         if (!isPlaying)
//                                           const Center(
//                                             child: CircularProgressIndicator(
//                                               color: Colors.blue,
//                                             ),
//                                           ),
//                                         Positioned(
//                                           top: 30,
//                                           right: 20,
//                                           child: IconButton(
//                                             icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                                             onPressed: () {
//                                               popupController.stop();
//                                               popupController.dispose();
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           );
//                         },
//
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
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

import 'Controller/CameraController.dart';

class CameraSection extends StatefulWidget {
  const CameraSection({super.key});

  @override
  State<CameraSection> createState() => _CameraSectionState();
}

class _CameraSectionState extends State<CameraSection> {
  final _vlcControllers = <int, VlcPlayerController>{};

  @override
  void initState() {
    super.initState();
    Get.find<Cameracontroller>().CameraDataz();
  }

  @override
  void dispose() {
    // Dispose all VLC controllers
    for (var controller in _vlcControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  VlcPlayerController _getOrCreateController(String url, int index) {
    if (_vlcControllers.containsKey(index)) {
      return _vlcControllers[index]!;
    }
    final controller = VlcPlayerController.network(
      url,
      hwAcc: HwAcc.auto,
      autoPlay: true,
    );
    _vlcControllers[index] = controller;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "LIVE CAMERA",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: GetX<Cameracontroller>(
              builder: (controller) {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.CameraList.isEmpty) {
                  return const Center(
                    child: Text("No camera data", style: TextStyle(color: Colors.white)),
                  );
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 16 / 9,
                  ),
                  itemCount: controller.CameraList.length,
                  itemBuilder: (context, index) {
                    final cam = controller.CameraList[index];
                    final rtspLink = cam?.rtspLink ?? '';
                    final vlcController = _getOrCreateController(rtspLink, index);

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            final popupController = VlcPlayerController.network(
                              rtspLink,
                              hwAcc: HwAcc.auto,
                              autoPlay: true,
                            );

                            return Dialog(
                              backgroundColor: Colors.black,
                              insetPadding: EdgeInsets.zero,
                              child: Stack(
                                children: [
                                  Center(
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: VlcPlayer(
                                        controller: popupController,
                                        aspectRatio: 16 / 9,
                                        placeholder: const Center(child: CircularProgressIndicator()),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 30,
                                    right: 20,
                                    child: IconButton(
                                      icon: const Icon(Icons.close, color: Colors.white),
                                      onPressed: () {
                                        popupController.stop();
                                        popupController.dispose();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        color: Colors.black,
                        child: VlcPlayer(
                          controller: vlcController,
                          aspectRatio: 16 / 9,
                          placeholder: const Center(child: CircularProgressIndicator()),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
