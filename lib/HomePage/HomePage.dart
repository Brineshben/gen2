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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey, // Important to control the drawer

        // resizeToAvoidBottomInset: false,
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
          leadingWidth: 320, // To give enough space for the logo
          leading: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 7,bottom: 7,right: 10),                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    height: 50,
                    width: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      border: Border.all(
                        color: Colors.blue,
                        width: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/menu_icon.svg", // Ensure this path is correct
                        // width: 40,
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 15,top: 7,bottom: 7,right: 10),
              //   child: Container(
              //     height: 60,
              //     w
              //     child: SvgPicture.asset(
              //       "assets/menu_icon.svg", // Ensure this path is correct
              //       // width: 40,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
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
                      ),                ),
                  ],
                ),
              ),
            ],
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
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.grey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // const DrawerHeader(
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //   ),
                  //   child:
                  //   Center(
                  //     child: Text(
                  //       'I HUB ROBOTICS',
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.home),
                      label: Text("Home"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.settings),
                      label: Text("Settings"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {},
                      icon: Icon(Icons.logout),
                      label: Text("Logout"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: const Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: ChatPage()),
                  // Expanded(child: CameraSection()),
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
