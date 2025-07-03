import 'package:flutter/material.dart';
import 'package:gen2/robot_status.dart';
import 'package:get/get.dart';

import '../Service/ApiService.dart';
import '../Service/popups.dart';
import 'Controller/jointController.dart';
import 'Controller/jointdatasController.dart';

class MotorSection extends StatefulWidget {
  const MotorSection({super.key});

  @override
  State<MotorSection> createState() => _MotorSectionState();
}

class _MotorSectionState extends State<MotorSection> {
  bool isL1Selected = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("JOINT CONTROLLER", style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ToggleButtons(
                  isSelected: [isL1Selected, !isL1Selected],
                  onPressed: (index) {
                    Get.find<Jointcontroller>().jointDataz();
                    Get.find<Jointcontroller2>().jointDatazz();
                    setState(() {
                      isL1Selected = (index == 0);
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  borderColor: Colors.grey.shade400,
                  selectedBorderColor: Colors.red.shade700,
                  disabledColor: Colors.white,
                  selectedColor: Colors.white,
                  fillColor: Colors.redAccent,
                  color: Colors.black87,
                  splashColor: Colors.red.shade100,
                  constraints:
                      const BoxConstraints(minHeight: 45, minWidth: 80),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text("L", style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text("R", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RobotStatusScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(width: 8),
                        Text(
                          'ROBOT STATUS',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Replace Expanded + ListView inside SingleChildScrollView with fixed height
            isL1Selected
                ? Expanded(
                    child: GetX<Jointcontroller>(builder: (controller) {
                      // if (controller.isLoading.value) {
                      //   return const Center(
                      //     child: CircularProgressIndicator(
                      //       color: Colors.blue,
                      //     ),
                      //   );
                      // }
                      if (controller.valueList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Data from Api",
                            style: TextStyle(
                                color: Colors.red, fontStyle: FontStyle.italic),
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                List<int> jointValues = controller.valueList
                                    .map((e) => e.toInt())
                                    .toList();

                                Map<String, dynamic> resp =
                                    await ApiServices.JointControls(
                                  arm: '1',
                                  joints: jointValues,
                                );

                                print("--------resp resp------------$resp");
                                if (resp['status'] == "ok") {
                                  ProductAppPopUps.submit(
                                    title: "Success",
                                    message: "joint updated Successfully",
                                    actionName: "Close",
                                    iconData: Icons.done,
                                    iconColor: Colors.green,
                                  );
                                } else {
                                  ProductAppPopUps.submit(
                                    title: "Error",
                                    message: "Something went wrong ",
                                    actionName: "Close",
                                    iconData: Icons.error_outline_outlined,
                                    iconColor: Colors.red,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                backgroundColor: Colors.blue, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8, // Shadow elevation
                              ),
                              child: const Text(
                                'L Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.valueList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text("J${index + 1}",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Slider(
                                          value: controller.valueList[index],
                                          min: controller.minValues[index],
                                          max: controller.maxValues[index],
                                          onChanged: (newVal) {
                                            controller.valueList[index] =
                                                newVal;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        controller.valueList[index]
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                            Expanded(
                              child: GetX<JointDatasController>(
                                builder: (JointDatasController controller) {
                                  final dataz = controller.jointData.value?.data;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("L ARM END POSE",
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text("X : ${dataz?.x}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("Y : ${dataz?.y}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("Z : ${dataz?.z}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("RX : ${dataz?.rx}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("RY : ${dataz?.ry}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("RZ : ${dataz?.rz}",
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                    }),
                  )
                : Expanded(
                    child: GetX<Jointcontroller2>(builder: (controller) {
                      // if (controller.isLoading.value) {
                      //   return const Center(
                      //     child: CircularProgressIndicator(
                      //       color: Colors.blue,
                      //     ),
                      //   );
                      // }
                      if (controller.valueList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Data from Api",
                            style: TextStyle(
                                color: Colors.red, fontStyle: FontStyle.italic),
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                List<int> jointValues = controller.valueList
                                    .map((element) => element.toInt())
                                    .toList();
                                Map<String, dynamic> resp =
                                    await ApiServices.JointControls(
                                  arm: '2',
                                  joints: jointValues,
                                );

                                print("--------resp resp------------$resp");
                                if (resp['status'] == "ok") {
                                  ProductAppPopUps.submit(
                                    title: "Success",
                                    message: "joint updated Successfully",
                                    actionName: "Close",
                                    iconData: Icons.done,
                                    iconColor: Colors.green,
                                  );
                                } else {
                                  ProductAppPopUps.submit(
                                    title: "Error",
                                    message: "Something went wrong ",
                                    actionName: "Close",
                                    iconData: Icons.error_outline_outlined,
                                    iconColor: Colors.red,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6),
                                backgroundColor: Colors.blue, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8, // Shadow elevation
                              ),
                              child: const Text(
                                'R Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.valueList.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Text("J${index + 1}",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      const SizedBox(width: 5),
                                      Expanded(
                                        child: Slider(
                                          value: controller.valueList[index],
                                          min: controller.minValues[index],
                                          max: controller.maxValues[index],
                                          onChanged: (newVal) {
                                            controller.valueList[index] =
                                                newVal;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        controller.valueList[index]
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                           Expanded(
                                  child: GetX<JointDatasController2>(
                                                                builder: (JointDatasController2 controller) {
                                  final dataz = controller.jointData.value?.data;
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("ARM R END POSE",
                                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                      Text("X : ${dataz?.x}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("Y : ${dataz?.y}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("Z : ${dataz?.z}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("RX : ${dataz?.rx}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("RY : ${dataz?.ry}",
                                          style: TextStyle(color: Colors.white)),
                                      Text("RZ : ${dataz?.rz}",
                                          style: TextStyle(color: Colors.white)),
                                    ],
                                  );
                                                                },
                                                              ),
                                ),
                          ],
                        );
                      }
                    }),
                  ),

          ],
        ),
      ),
    );
  }
}
