import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/auth/register/controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}