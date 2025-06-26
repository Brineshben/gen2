import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    Get.find<Jointcontroller>().jointDataz();
    Get.find<Jointcontroller2>().jointDatazz();
    Get.find<JointDatasController>().JointValueData();
    Get.find<JointDatasController2>().JointValueData2();
    Get.find<Cameracontroller>().CameraDataz();
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  MotorSection(),
                  // CameraSection(),
                ],
              ),
            ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       MotorSection(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton:JoystickPage(),
    );
  }
}
