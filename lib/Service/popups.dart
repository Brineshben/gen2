import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductAppPopUps {
  static final ProductAppPopUps _instance = ProductAppPopUps._internal();

  ProductAppPopUps._internal();

  factory ProductAppPopUps() {
    return _instance;
  }

  static submit({
    String? title,
    required String message,
    required String actionName,
    required IconData iconData,
    required Color iconColor,
  }) {
    return Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Column(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 50.h,
            ),
            if (title != null) SizedBox(height: 10.w),
            if (title != null)
              Text(
                title,
                style: GoogleFonts.oxygen(
                    color: Colors.blueGrey,
                    fontSize: 18.h,
                    fontWeight: FontWeight.bold),
              ),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.h, color: Colors.blueGrey),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            onPressed: () {
              Get.back();
            },
            style: ButtonStyle(
              backgroundColor:
              WidgetStateProperty.all(Colors.blue),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  actionName,
                  style: TextStyle(color: Colors.white, fontSize: 16.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}