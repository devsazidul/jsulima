import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/icon_path.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/splash_screen/controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  final SplashScreenController controller = Get.put(SplashScreenController()); 

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50
          ),
          child: Column(
           
            children: [
              Spacer(), 
              Image.asset(IconPath.appIcon, 
              height: height * 0.6,
              width: width * 0.6,
              ), 
              Spacer(),  
              SizedBox(
                width: width * 0.3,
                child: Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}