import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jsulima/core/services/shared_preferences_helper.dart';
import 'package:jsulima/features/profile/screen/profile_screen.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isCurrentObscured = true.obs;
  final isNewObscured = true.obs;
  final isConfirmObscured = true.obs;

  void toggleObscure(String field) {
    switch (field) {
      case 'current':
        isCurrentObscured.value = !isCurrentObscured.value;
        break;
      case 'new':
        isNewObscured.value = !isNewObscured.value;
        break;
      case 'confirm':
        isConfirmObscured.value = !isConfirmObscured.value;
        break;
    }
  }

  Future<void> saveChanges() async {
    if (newPasswordController.text != confirmPasswordController.text) {
      EasyLoading.showError("Passwords do not match");
      return;
    }

    var token = SharedPreferencesHelper.getAccessToken().toString();
    final updatedFields = {
      'currentPassword': currentPasswordController.text,
      'newPassword': newPasswordController.text,
      'retypeNewPassword': confirmPasswordController.text,
    };

    if (kDebugMode) {
      print("change password token: $token");
      print("change password fields: $updatedFields");
    }

    if (token == '') {
      EasyLoading.showError('Token is empty');
      throw Exception('Token is empty');
    }

    try {
      final response = await http.patch(
        Uri.parse('http://184.105.208.66:8000/auth/change-password'),
        headers: {
          'Authorization':
              'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedFields),
      );

      if (kDebugMode) {
        print("change password response: ${response.body}");
        print("change password status code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['message'] == 'Password changed successfully') {
          EasyLoading.showSuccess('Password changed successfully');
          Get.to(ProfileScreen());
        } else {
          EasyLoading.showError('Failed to change password');
          throw Exception(
            'Unexpected response: ${responseBody['message'] ?? 'Unknown error'}',
          );
        }
      } else {
        EasyLoading.showError('Failed to change password');
        throw Exception('Failed to change password: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("change password error: $e");
      }
      EasyLoading.showError('Failed to change password.');
      rethrow;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
