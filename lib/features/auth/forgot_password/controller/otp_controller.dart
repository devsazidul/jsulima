import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jsulima/features/auth/forgot_password/controller/confirm_password_controller.dart';
import 'package:jsulima/features/auth/forgot_password/screen/confirm_password.dart';
import 'package:jsulima/features/auth/forgot_password/service/otp_service.dart';

class OtpController extends GetxController {
  final otpCode = "".obs;
  final OtpService _service = OtpService();

  late String email;

  void setOtp(String otp) {
    otpCode.value = otp;
  }

  void setEmail(String userEmail) {
    email = userEmail;
  }

  Future<void> verifyOtp() async {
    final code = otpCode.value.trim();

    if (code.length != 4) {
      EasyLoading.showError("Please enter the 4-digit OTP");
      return;
    }

    EasyLoading.show(status: "Verifying...");
    final result = await _service.verifyOtp(email, code);
    await EasyLoading.dismiss();

    if (result["ok"] == true) {
      EasyLoading.showSuccess(result["message"] ?? "OTP Verified");
      Future.delayed(const Duration(milliseconds: 800), () {
        final controller = Get.put(ConfirmPasswordController());
        controller.setEmail(email);
        Get.to(() => const ConfirmPassword());
      });
    } else {
      EasyLoading.showError(result["message"] ?? "Invalid OTP");
    }
  }
}
