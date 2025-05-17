import 'dart:convert';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http show post;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';
import 'package:jsulima/features/auth/register/profile_setup/screens/upload_image_screen.dart' show UploadImageScreen;

class RegisterController extends GetxController {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    try {
      EasyLoading.show(status: "Loading..."); 
      if(passwordController.text != confirmPasswordController.text){
        EasyLoading.showError("Password missmatch");
        return;
      }
      final data = {
        "fullName": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
      };
      
      final response = await http.post(
        Uri.parse('${Urls.baseUrl}/auth/register'), 
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      ); 

      var body = jsonDecode(response.body);

      if(response.statusCode == 201){
        EasyLoading.showSuccess("The user registered successfully"); 
        final accessToken = body['accessToken']; 
        final role = body['user']['role']; 

        await SharedPreferencesHelper.saveTokenAndRole(accessToken, role); 

        Get.offAll(() => UploadImageScreen());

      }
      else{
        EasyLoading.showError(body['message']);
        if (kDebugMode) {
          print("Error occueed");
        } 
      }

    } catch (e) {
      EasyLoading.showError("Error $e");
      if (kDebugMode) {
        print("The exception occured is $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
