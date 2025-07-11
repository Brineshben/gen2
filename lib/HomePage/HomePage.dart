import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../Camera/Controller/CameraController.dart';
import '../Camera/camera_page.dart';
import '../Chat_Page/chatpage.dart';
import '../JointControl/Controller/jointController.dart';
import '../JointControl/Controller/jointdatasController.dart';
import '../JointControl/joint_Control.dart';
import '../joystick/joystick_page.dart';

class FourSectionScreen extends StatefulWidget {
  const FourSectionScreen({super.key});

  @override
  State<FourSectionScreen> createState() => _FourSectionScreenState();
}

class _FourSectionScreenState extends State<FourSectionScreen> {
  Timer? messageTimer2;

  // @override
  // void initState() {
  //   super.initState();
  //   messageTimer2 = Timer.periodic(const Duration(milliseconds: 500 ), (timer) {
  //     print("HomePage initialized");
  //
  //     Get.find<JointDatasController>().JointValueData();
  //     Get.find<JointDatasController2>().JointValueData2();
  //   });
  //
  //   Get.find<Jointcontroller>().jointDataz();
  //   Get.find<Jointcontroller2>().jointDatazz();
  //
  //   Get.find<Cameracontroller>().CameraDataz();
  //
  // }

  @override
  void initState() {
    super.initState();

    messageTimer2 = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (Get.isRegistered<JointDatasController>()) {
        Get.find<JointDatasController>().JointValueData();
      }
      if (Get.isRegistered<JointDatasController2>()) {
        Get.find<JointDatasController2>().JointValueData2();
      }
    });

    if (Get.isRegistered<Jointcontroller>()) {
      Get.find<Jointcontroller>().jointDataz();
    }
    if (Get.isRegistered<Jointcontroller2>()) {
      Get.find<Jointcontroller2>().jointDatazz();
    }
    if (Get.isRegistered<Cameracontroller>()) {
      Get.find<Cameracontroller>().CameraDataz();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          // title: const Text(
          //   'TARA GEN2',
          //   style: TextStyle(color: Colors.white),
          // ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          leadingWidth: 160, // To give enough space for the logo
          leading: Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Stack(
              children: [
                Image.asset(
                  "assets/logo1.png",
                  width: 140,
                  color: Colors.white,
                ),
                const Positioned(
                  top: 6,
                  left: 7,
                  child: Text(
                    "POWERED BY",
                    style: TextStyle(
                      fontSize: 5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Make it visible on dark background
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.asset(
                "assets/brake.png",
                width: 140,
              ),
            ),
            SizedBox(width: 5,),

            SvgPicture.asset(
              "assets/alert-icon-orange.svg", // Ensure this path is correct
              width: 40,
            ),
            SizedBox(width: 45,)
          ],

        ),
        body: const Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: ChatPage()),
                  Expanded(child: CameraSection()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  MotorSection(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: const JoystickPage(),
      ),
    );
  }
}
// Expanded(child: CameraSection()),
