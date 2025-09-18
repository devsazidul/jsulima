import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jsulima/routes/app_routes.dart';
import 'core/bindings/controller_binder.dart';
import 'core/utils/theme/theme.dart';

class Jsulima extends StatelessWidget {
  const Jsulima({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final designSize =
        screenWidth > 600 ? const Size(1024, 1366) : const Size(390, 844);
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,

      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          initialRoute: AppRoute.getSplashScreen(),
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
