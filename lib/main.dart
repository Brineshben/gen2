import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'HomePage/HomePage.dart';
import 'Service/controller_handling.dart';

void main() {
  HandleControllers.createGetControllers();

  runApp(
    ScreenUtilInit(
      designSize: const Size(430, 930),
      minTextAdapt: true,
      splitScreenMode: true,
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: FourSectionScreen(),
      ),
    ),
  );
}
