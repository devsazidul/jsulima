import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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

  void saveChanges() {
    if (newPasswordController.text == confirmPasswordController.text) {
      EasyLoading.showSuccess("Password changed successfully");
    } else {
      EasyLoading.showError("Passwords do not match");
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
