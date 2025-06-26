import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Camera/Controller/CameraController.dart';
import '../Camera/camera_page.dart';
import '../Chat_Page/view/chatpage.dart';
import '../JointControl/Controller/jointController.dart';
import '../JointControl/joint_Control.dart';
import '../joystick/joystick_page.dart';

class FourSectionScreen extends StatefulWidget {
  const FourSectionScreen({super.key});

  @override
  State<FourSectionScreen> createState() => _FourSectionScreenState();

  static Widget _buildSection(
    BuildContext context, {
    required String title,
    required Color color,
    required Widget page,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
        child: Container(
          color: color,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _FourSectionScreenState extends State<FourSectionScreen> {
  @override
  void initState() {
    Get.find<Jointcontroller>().jointDataz();
    Get.find<Jointcontroller2>().jointDatazz();

    Get.find<Cameracontroller>().CameraDataz();
    super.initState();
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
                  // CameraSection(),
                  // CameraSection(),
                  Expanded(child: ChatPage()),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  MotorSection(),
                  // JoystickPage(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: JoystickPage(),
    );
  }
}
