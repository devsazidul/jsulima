import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http show post;
import 'package:jsulima/core/services/end_points.dart' show Urls;
import 'package:jsulima/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:jsulima/features/auth/register/profile_setup/screens/choose_your_plan_screen.dart'
    show ChooseYourPlanScreen;
import 'package:jsulima/features/bottom_navbar/screen/bottom_navbar_screen.dart'
    show BottomNavbarScreen;

class LoginScreenController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isRememberMeChecked = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMeChecked.value = !isRememberMeChecked.value;
  }

  Future<void> login() async {
    try {
      EasyLoading.show(status: "Loading...");
      final data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final response = await http.post(
        Uri.parse(Urls.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      var body = jsonDecode(response.body);

      if (response.statusCode == 201) {
        EasyLoading.showSuccess("The user logged in successfully");
        var accessToken = body['access_token'];
        var role = body['user']['role'];
        var isSubscribed = body['user']['isSubscribed'];
        var userId = body['user']['id'];

        await SharedPreferencesHelper.saveTokenAndRole(
          accessToken,
          role,
          userId,
        );
        await SharedPreferencesHelper.isSubscribed(isSubscribed);

        if (isSubscribed == null) {
          Get.offAll(() => ChooseYourPlanScreen());
        } else {
          Get.offAll(() => BottomNavbarScreen());
        }
      } else {
        EasyLoading.showError(body['message']);
      }
    } catch (e) {
      if (kDebugMode) {
        EasyLoading.showError("Something went wrong");
        print("Exception $e");
        print("The email: ${emailController.text}");
        print("The password: ${passwordController.text}");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
