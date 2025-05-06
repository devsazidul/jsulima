import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/auth/login/controller/login_screen_controller.dart';
import 'package:jsulima/features/auth/login/widget/content_container.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final LoginScreenController controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ContentContainer(),
          ),
        ),
      ),
    );
  }
}
