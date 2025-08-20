import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/auth/register/profile_setup/screens/upload_image_screen.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify OTP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Please enter 4 digit OTP sent to your email",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFCCCCCC).withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 40),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Color(0xFF979797),
                focusedBorderColor: Colors.white,
                cursorColor: Colors.white,
                showFieldAsBox: true,
                borderRadius: BorderRadius.circular(8),
                fieldWidth: 50,
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.10),
                onSubmit: (otp) {
                  if (kDebugMode) {
                    print("Entered OTP: $otp");
                  }
                },
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979797), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979797), width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 40),
              CustomButton(
                text: "Register",
                onPressed: () {
                  Get.to(UploadImageScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
