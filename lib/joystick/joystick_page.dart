import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Service/ApiService.dart';
import '../Service/popups.dart';

class JoystickPage extends StatelessWidget {
  const JoystickPage({super.key});

  Future<void> sendDirection(String direction, BuildContext context) async {
    String value = "";

    switch (direction) {
      case 'up':
        value = "forward:50";
        break;
      case 'down':
        value = "backward:50";
        break;
      case 'left':
        value = "left:0.174533";
        break;
      case 'right':
        value = "right:-0.174533";
        break;
    }

    final resp = await ApiServices.JoystickService(value: value);

    if (resp['status'] == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            width: MediaQuery.of(context).size.width*0.20,
            elevation: 1.0,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
            content: Wrap(
              children: [
                Container(
                  //height: 20,
                  child: Center(
                    child: Text(
                      '${direction.toUpperCase()} is pressed',
                    ),
                  ),
                ),
              ],
            ),
          )
      );
      // Get.snackbar(
      //   'Success',
      //   '${direction.toUpperCase()} is pressed',
      //   snackPosition: SnackPosition.TOP,
      //   backgroundColor: Colors.white,
      //   colorText: Colors.black,
      //   borderRadius: 8,
      //   margin: const EdgeInsets.all(10),
      //   snackStyle: SnackStyle.FLOATING,
      // );
    } else {
      ProductAppPopUps.submit(
        title: "Error",
        message: "Something went wrong",
        actionName: "Close",
        iconData: Icons.error_outline_outlined,
        iconColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16), // Adjust padding to control the size
                backgroundColor: Colors.white, // Button background color
                elevation: 4,
              ),
              onPressed: () => sendDirection("up", context),
              child: const Icon(Icons.keyboard_arrow_up_outlined,color: Colors.blueGrey,size: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16), // Adjust padding to control the size
                    backgroundColor: Colors.white, // Button background color
                    elevation: 4,
                  ),
                  onPressed: () => sendDirection("left", context),
                  child: const Icon(Icons.arrow_back_ios_new_outlined,color: Colors.blueGrey,),
                ),
                const SizedBox(width: 35),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16), // Adjust padding to control the size
                    backgroundColor: Colors.white, // Button background color
                    elevation: 4,
                  ),
                  onPressed: () => sendDirection("right", context),
                  child: const Icon(Icons.arrow_forward_ios,color: Colors.blueGrey,),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16), // Adjust padding to control the size
                backgroundColor: Colors.white, // Button background color
                elevation: 4,
              ),
              onPressed: () => sendDirection("down", context),
              child: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.blueGrey,size: 20,),
            ),
          ],
        ),
      ],
    );
  }
}
