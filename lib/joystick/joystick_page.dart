import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Service/ApiService.dart';
import '../Service/popups.dart';

class JoystickPage extends StatelessWidget {
  const JoystickPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Joystick(
        mode: JoystickMode.horizontalAndVertical,
        listener: (StickDragDetails details) async{
          final dx = details.x;
          final dy = details.y;

          if (dy < -0.5)  {
            Map<String, dynamic> resp =
                await ApiServices.JoystickService( value:"forward:100"
            );

            print("--------resp resp------------$resp");
            if (resp['status'] == "ok") {
              Get.snackbar('Success', 'TOP is pressed',
                  snackPosition: SnackPosition.TOP);
            } else {
              ProductAppPopUps.submit(
                title: "Error",
                message: "Something went wrong ",
                actionName: "Close",
                iconData: Icons.error_outline_outlined,
                iconColor: Colors.red,
              );
            }          } else if (dy > 0.5) {
            Map<String, dynamic> resp =
            await ApiServices.JoystickService( value:"backward:100"
            );

            print("--------resp resp------------$resp");
            if (resp['status'] == "ok") {
              Get.snackbar('Success', 'BOTTOM is pressed',
                  snackPosition: SnackPosition.TOP);
            } else {
              ProductAppPopUps.submit(
                title: "Error",
                message: "Something went wrong ",
                actionName: "Close",
                iconData: Icons.error_outline_outlined,
                iconColor: Colors.red,
              );
            }
            print("DOWN");
          } else if (dx < -0.5) {
            Map<String, dynamic> resp =
            await ApiServices.JoystickService( value:"left:0.174533"
            );

            print("--------resp resp------------$resp");
            if (resp['status'] == "ok") {
              Get.snackbar('Success', 'LEFT is pressed',
                  snackPosition: SnackPosition.TOP);
            } else {
              ProductAppPopUps.submit(
                title: "Error",
                message: "Something went wrong ",
                actionName: "Close",
                iconData: Icons.error_outline_outlined,
                iconColor: Colors.red,
              );
            }
            print("LEFT");
          } else if (dx > 0.5) {
            Map<String, dynamic> resp =
            await ApiServices.JoystickService( value:"right:-0.174533"
            );

            print("--------resp resp------------$resp");
            if (resp['status'] == "ok") {
              Get.snackbar('Success', 'RIGHT is pressed',
                  snackPosition: SnackPosition.TOP);
            } else {
              ProductAppPopUps.submit(
                title: "Error",
                message: "Something went wrong ",
                actionName: "Close",
                iconData: Icons.error_outline_outlined,
                iconColor: Colors.red,
              );
            }
            print("RIGHT");
          }
        },
        base: JoystickBase(
          decoration: JoystickBaseDecoration(
            color: Colors.transparent,
            drawOuterCircle: false,
          ),
          arrowsDecoration: JoystickArrowsDecoration(
            color: Colors.blue,
          ),
        ),
      ),

    );
  }
}
