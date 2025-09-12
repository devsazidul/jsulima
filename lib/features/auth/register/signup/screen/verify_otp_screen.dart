import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/auth/register/profile_setup/screens/upload_image_screen.dart';
import 'package:jsulima/features/auth/register/signup/screen/register_screen.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  const VerifyOtpScreen({
    super.key,
    required this.email,
    required this.name,
    required this.password,
    required this.phoneNumber,
  });

  Future<void> verifyOtp(String otp) async {
    try {
      EasyLoading.show(status: "Verifying...");

      final data = {
        "fullName": name,
        "email": email,
        "otp": otp,
        "password": password,
        "phoneNumber": phoneNumber,
      };

      final response = await http.post(
        Uri.parse(Urls.otpVerify),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 201) {
        EasyLoading.showSuccess("OTP Verified Successfully");

        final accessToken = body['accessToken'];
        final role = body['user']['role'];
        final userId = body['user']['id'];

        await SharedPreferencesHelper.saveTokenAndRole(
          accessToken,
          role,
          userId,
        );

        Get.offAll(() => UploadImageScreen());
      } else {
        EasyLoading.showError(body['message'] ?? "OTP Verification Failed");
        if (kDebugMode) {
          print("Error occurred: ${body['message']}");
        }
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
      if (kDebugMode) {
        print("Exception occurred: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    String otpCode = "";

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
                "Please enter 4 digit OTP sent to your email $email",
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
                  otpCode = otp;
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
                text: 'Back',
                onPressed: () {
                  Get.offAll(RegisterScreen());
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                text: "Verify OTP",
                onPressed: () {
                  if (otpCode.isEmpty) {
                    EasyLoading.showError("Please enter the OTP");
                  } else {
                    verifyOtp(otpCode);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
