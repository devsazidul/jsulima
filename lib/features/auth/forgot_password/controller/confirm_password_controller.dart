import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jsulima/features/auth/forgot_password/service/confirm_password_service.dart';
import 'package:jsulima/features/auth/login/screen/login_screen.dart';

class ConfirmPasswordController extends GetxController {
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  final ConfirmPasswordService _service = ConfirmPasswordService();

  late String email;
  void setEmail(String userEmail) {
    email = userEmail;
  }

  void setNewPassword(String value) {
    newPassword.value = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void confirm() async {
    if (newPassword.value.isEmpty || confirmPassword.value.isEmpty) {
      EasyLoading.showError("Please fill all fields");
      return;
    }

    if (newPassword.value != confirmPassword.value) {
      EasyLoading.showError("Passwords do not match");
      return;
    }

    if (newPassword.value.length < 6) {
      EasyLoading.showError("Password must be at least 6 characters");
      return;
    }

    EasyLoading.show(status: "Updating password...");

    bool success = await _service.confirmPassword(
      email: email,
      newPassword: newPassword.value,
    );

    if (success) {
      EasyLoading.showSuccess("Password updated successfully");
      Get.offAll(LoginScreen());
    } else {
      EasyLoading.showError("Failed to update password");
    }
  }
}
