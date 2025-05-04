import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  var emailController = TextEditingController();
  var  passwordController = TextEditingController();
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
