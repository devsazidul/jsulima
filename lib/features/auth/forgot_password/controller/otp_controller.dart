import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jsulima/features/auth/forgot_password/screen/confirm_password.dart';

class OtpController extends GetxController {
  var otpCode = "".obs;

  void setOtp(String otp) {
    otpCode.value = otp;
  }

  void verifyOtp() {
    if (otpCode.isEmpty) {
      EasyLoading.showError("Please enter the OTP");
    } else {
      EasyLoading.showSuccess("OTP Verified: ${otpCode.value}");
      Get.to(() => ConfirmPassword());
    }
  }
}
