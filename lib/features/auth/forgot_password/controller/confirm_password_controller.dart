import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ConfirmPasswordController extends GetxController {
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;

  void setNewPassword(String value) {
    newPassword.value = value;
  }

  void setConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void confirm() {
    if (newPassword.value.isEmpty || confirmPassword.value.isEmpty) {
      EasyLoading.showError("Please fill all fields");
    } else if (newPassword.value != confirmPassword.value) {
      EasyLoading.showError("Passwords do not match");
    } else if (newPassword.value.length < 6) {
      EasyLoading.showError("Password must be at least 6 characters");
    } else {
      EasyLoading.showSuccess("Password confirmed successfully");
    }
  }
}
