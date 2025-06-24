import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/ApiService.dart';
import '../Service/popups.dart';
import 'Controller/jointController.dart';

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
                      child: Text("L1", style: TextStyle(color: Colors.white)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Text("L2", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),

              ],
            ),
            const SizedBox(height: 20),
            // Replace Expanded + ListView inside SingleChildScrollView with fixed height
            isL1Selected
                ? Expanded(
                  child: GetX<Jointcontroller>(builder: (controller) {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
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
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                Map<String, dynamic> resp =
                                await ApiServices.JointControls(
                                  arm: '1',
                                  j1:  controller.valueList[0].toInt(),
                                  j2:controller.valueList[1].toInt(),
                                  j3:  controller.valueList[2].toInt(),
                                  j4:  controller.valueList[3].toInt(),
                                  j5: controller.valueList[4].toInt(),
                                  j6:  controller.valueList[5].toInt(),
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
                                backgroundColor:
                                Colors.blue, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8, // Shadow elevation
                              ),
                              child: const Text(
                                'L1 Update',
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
                                          style: TextStyle(color: Colors.white)),
                                      const SizedBox(width: 5),
                              
                                      Expanded(
                                        child: Slider(
                                          value: controller.valueList[index],
                                          min: controller.minValues[index],
                                          max: controller.maxValues[index],
                                          onChanged: (newVal) {
                                            controller.valueList[index] = newVal;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        controller.valueList[index].toStringAsFixed(1),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                )
                : Expanded(
                  child: GetX<Jointcontroller2>(
                    builder: (controller) {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      }
                      if (controller.valueList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Data from Api",
                            style: TextStyle(
                                color: Colors.red, fontStyle: FontStyle
                                .italic),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                Map<String, dynamic> resp =
                                await ApiServices.JointControls(
                                  arm: '2',
                                  j1:  controller.valueList[0].toInt(),
                                  j2:controller.valueList[1].toInt(),
                                  j3:  controller.valueList[2].toInt(),
                                  j4:  controller.valueList[3].toInt(),
                                  j5: controller.valueList[4].toInt(),
                                  j6:  controller.valueList[5].toInt(),
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
                                backgroundColor:
                                Colors.blue, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 8, // Shadow elevation
                              ),
                              child: const Text(
                                'L2 Update',
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
                                          style: TextStyle(
                                              color: Colors.white)),
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
                          ],
                        );
                      }
                    }
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class MotorSlider extends StatelessWidget {
  final int index;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const MotorSlider({
    Key? key,
    required this.index,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: Text(
              'J${index + 1}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              label: value.toStringAsFixed(0),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              value.toStringAsFixed(0),
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Joint Sliders
// isL1Selected? GetX<Jointcontroller>(
//   builder: (Jointcontroller controller) {
//     List<double> valueList = controller.valueList.value;
//
//     return Column(
//       children: [
//
//
//         Row(
//           children: [
//             Text(
//               "J1",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[0],
//                 min: minimumValue(0).toDouble(),
//                 max: maximumValue(0).toDouble(),
//                 divisions: 100,
//                 label: valueList[0].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[0] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[0].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J2",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[1],
//                 min: minimumValue(1).toDouble(),
//                 max: maximumValue(1).toDouble(),
//                 divisions: 100,
//                 label: valueList[1].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[1] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[1].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J3",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[2],
//                 min: minimumValue(2).toDouble(),
//                 max: maximumValue(2).toDouble(),
//                 divisions: 100,
//                 label: valueList[2].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[2] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[2].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J4",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[3],
//                 min: minimumValue(3).toDouble(),
//                 max: maximumValue(3).toDouble(),
//                 divisions: 100,
//                 label: valueList[3].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[3] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[3].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J5",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[4],
//                 min: minimumValue(4).toDouble(),
//                 max: maximumValue(4).toDouble(),
//                 divisions: 100,
//                 label: valueList[4].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[4] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[4].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J6",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[5],
//                 min: minimumValue(5).toDouble(),
//                 max: maximumValue(5).toDouble(),
//                 divisions: 100,
//                 label: valueList[5].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[5] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[5].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//
//       ElevatedButton(
//         onPressed: () async {
//           Map<String, dynamic> resp =
//           await ApiServices.JointControls(
//             arm: '1',
//             j1: valueList[0].toInt(),
//             j2: valueList[1].toInt(),
//             j3: valueList[2].toInt(),
//             j4: valueList[3].toInt(),
//             j5: valueList[4].toInt(),
//             j6: valueList[5].toInt(),
//           );
//
//           print("--------resp resp------------$resp");
//           if (resp['status'] == "ok") {
//             ProductAppPopUps.submit(
//               title: "Success",
//               message: "joint updated Successfully",
//               actionName: "Close",
//               iconData: Icons.done,
//               iconColor: Colors.green,
//             );
//           } else {
//             ProductAppPopUps.submit(
//               title: "Error",
//               message: "Something went wrong ",
//               actionName: "Close",
//               iconData: Icons.error_outline_outlined,
//               iconColor: Colors.red,
//             );
//           }
//         },
//         style: ElevatedButton.styleFrom(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 24, vertical: 12),
//           backgroundColor: Colors.blue, // Button color
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 8, // Shadow elevation
//         ),
//         child: const Text(
//           'L1 Update',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       )
//         //j1 to j6 vara und
//         //               ...List.generate(valueList.length, (index) {
//         //                 return Expanded(
//         //                   child: Row(
//         //                     children: [
//         //                       Text(
//         //                         "J${index + 1}",
//         //                         style: TextStyle(fontSize: 20, color: Colors.white),
//         //                       ),
//         //                       Expanded(
//         //                         child: Slider(
//         //                           value: valueList[index],
//         //                           min: minimumValue(index).toDouble(),
//         //                           max: maximumValue(index).toDouble(),
//         //                           divisions: 100,
//         //                           label: valueList[index].toStringAsFixed(0),
//         //                           onChanged: (value) {
//         //                             controller.valueList.value[index] = value; // Custom method to update the value
//         //                             controller.valueList.refresh();
//         //                           },
//         //                         ),
//         //                       ),
//         //                       Text(
//         //                         " ${valueList[index].toStringAsFixed(0)}",
//         //                         style: const TextStyle(fontSize: 20, color: Colors.white),
//         //                       ),
//         //                     ],
//         //                   ),
//         //                 );
//         //               },),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   },
// ):GetX<Jointcontroller2>(
//   builder: (Jointcontroller2 controller) {
//     List<double> valueList = controller.valueList.value;
//
//     return Column(
//       children: [
//
//
//         Row(
//           children: [
//             Text(
//               "L1",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[0],
//                 min: minimumValue(0).toDouble(),
//                 max: maximumValue(0).toDouble(),
//                 divisions: 100,
//                 label: valueList[0].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[0] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[0].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J2",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[1],
//                 min: minimumValue(1).toDouble(),
//                 max: maximumValue(1).toDouble(),
//                 divisions: 100,
//                 label: valueList[1].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[1] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[1].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J3",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[2],
//                 min: minimumValue(2).toDouble(),
//                 max: maximumValue(2).toDouble(),
//                 divisions: 100,
//                 label: valueList[2].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[2] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[2].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J4",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[3],
//                 min: minimumValue(3).toDouble(),
//                 max: maximumValue(3).toDouble(),
//                 divisions: 100,
//                 label: valueList[3].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[3] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[3].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J5",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[4],
//                 min: minimumValue(4).toDouble(),
//                 max: maximumValue(4).toDouble(),
//                 divisions: 100,
//                 label: valueList[4].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[4] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[4].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Text(
//               "J6",
//               style: TextStyle(fontSize: 20, color: Colors.white),
//             ),
//             Expanded(
//               child: Slider(
//                 value: valueList[5],
//                 min: minimumValue(5).toDouble(),
//                 max: maximumValue(5).toDouble(),
//                 divisions: 100,
//                 label: valueList[5].toStringAsFixed(0),
//                 onChanged: (value) {
//                   controller.valueList.value[5] =
//                       value; // Custom method to update the value
//                   controller.valueList.refresh();
//                 },
//               ),
//             ),
//             Text(
//               " ${valueList[5].toStringAsFixed(0)}",
//               style: const TextStyle(
//                   fontSize: 20, color: Colors.white),
//             ),
//           ],
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             Map<String, dynamic> resp =
//             await ApiServices.JointControls(
//               arm: '2',
//               j1: valueList[0].toInt(),
//               j2: valueList[1].toInt(),
//               j3: valueList[2].toInt(),
//               j4: valueList[3].toInt(),
//               j5: valueList[4].toInt(),
//               j6: valueList[5].toInt(),
//             );
//
//             print("--------resp resp------------$resp");
//             if (resp['status'] == "ok") {
//               ProductAppPopUps.submit(
//                 title: "Success",
//                 message: "joint updated Successfully",
//                 actionName: "Close",
//                 iconData: Icons.done,
//                 iconColor: Colors.green,
//               );
//             } else {
//               ProductAppPopUps.submit(
//                 title: "Error",
//                 message: "Something went wrong ",
//                 actionName: "Close",
//                 iconData: Icons.error_outline_outlined,
//                 iconColor: Colors.red,
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 24, vertical: 12),
//             backgroundColor: Colors.blue, // Button color
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             elevation: 8, // Shadow elevation
//           ),
//           child: const Text(
//             'L2 Update',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         )
//         //j1 to j6 vara und
//         //               ...List.generate(valueList.length, (index) {
//         //                 return Expanded(
//         //                   child: Row(
//         //                     children: [
//         //                       Text(
//         //                         "J${index + 1}",
//         //                         style: TextStyle(fontSize: 20, color: Colors.white),
//         //                       ),
//         //                       Expanded(
//         //                         child: Slider(
//         //                           value: valueList[index],
//         //                           min: minimumValue(index).toDouble(),
//         //                           max: maximumValue(index).toDouble(),
//         //                           divisions: 100,
//         //                           label: valueList[index].toStringAsFixed(0),
//         //                           onChanged: (value) {
//         //                             controller.valueList.value[index] = value; // Custom method to update the value
//         //                             controller.valueList.refresh();
//         //                           },
//         //                         ),
//         //                       ),
//         //                       Text(
//         //                         " ${valueList[index].toStringAsFixed(0)}",
//         //                         style: const TextStyle(fontSize: 20, color: Colors.white),
//         //                       ),
//         //                     ],
//         //                   ),
//         //                 );
//         //               },),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//         // Row(
//         //   children: [
//         //     const Text(
//         //       "J1",
//         //       style: TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //     Expanded(
//         //       child: Slider(
//         //         value: currentValue,
//         //         min: 0,
//         //         max: 100,
//         //         divisions: 100,
//         //         label: currentValue.toStringAsFixed(0),
//         //         onChanged: (value) {
//         //           controller.updateJ1(value.toInt()); // Custom method to update the value
//         //         },
//         //       ),
//         //     ),
//         //     Text(
//         //       " ${currentValue.toStringAsFixed(0)}",
//         //       style: const TextStyle(fontSize: 20, color: Colors.white),
//         //     ),
//         //   ],
//         // ),
//       ],
//     );
//   },
// )
int minimumValue(index) {
  switch (index) {
    case 0:
      return -154;
    case 1:
      return 0;
    case 2:
      return -175;
    case 3:
      return -106;
    case 4:
      return -75;
    case 5:
      return -100;
    default:
      return 0;
  }
}

int maximumValue(index) {
  switch (index) {
    case 0:
      return 154;
    case 1:
      return 195;
    case 2:
      return 0;
    case 3:
      return 106;
    case 4:
      return 75;
    case 5:
      return 100;
    default:
      return 100;
  }
}
