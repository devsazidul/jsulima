import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/auth/forgot_password/controller/otp_controller.dart';

class OtpVerify extends StatelessWidget {
  final String email;
  const OtpVerify({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController());
    controller.setEmail(email); // <-- IMPORTANT: pass verified email here

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Verify OTP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please enter 4 digit OTP sent to your email $email",
                style: TextStyle(
                  fontSize: 16,
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 40),

              // OTP Input
              OtpTextField(
                numberOfFields: 4,
                borderColor: const Color(0xFF979797),
                focusedBorderColor: Colors.white,
                cursorColor: Colors.white,
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(8),
                fieldWidth: 50,
                filled: true,
                // ignore: deprecated_member_use
                fillColor: Colors.white.withOpacity(0.1),
                onCodeChanged: (otp) {
                  controller.setOtp(otp);
                },
                onSubmit: (otp) {
                  controller.setOtp(otp);
                },
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),

              CustomButton(
                text: "Verify OTP",
                onPressed: () {
                  controller.verifyOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
