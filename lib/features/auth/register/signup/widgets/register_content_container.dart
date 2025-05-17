import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:jsulima/core/common/widgets/custom_button.dart'
    show CustomButton;
import 'package:jsulima/core/common/widgets/custom_textfield.dart'
    show CustomTextField;
import 'package:jsulima/core/utils/constants/colors.dart' show AppColors;
import 'package:jsulima/features/auth/login/screen/login_screen.dart';
import 'package:jsulima/features/auth/register/signup/controller/register_controller.dart';

class RegisterContentContainer extends StatelessWidget {
  RegisterContentContainer({super.key});

  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: Color(0xFF393939),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          children: [
            Text(
              "Sign Up",
              style: getTextStyle(
                color: Colors.white,
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: "Already have an account? ",
                style: getTextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: "Log In ",
                    style: getTextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            Get.offAll(() => LoginScreen());
                          },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Full Name",
                style: getTextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: controller.nameController,
              hintText: "John Doe",
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: getTextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: controller.emailController,
              hintText: "xyz@gmail.com",
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Phone Number",
                style: getTextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: controller.phoneController,
              hintText: "+1*****",
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: getTextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => CustomTextField(
                controller: controller.passwordController,
                hintText: "********",
                isObscure: controller.isPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.togglePasswordVisibility();
                  },
                  icon: Icon(
                    controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password",
                style: getTextStyle(
                  color: AppColors.greyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => CustomTextField(
                controller: controller.confirmPasswordController,
                hintText: "********",
                isObscure: controller.isConfirmPasswordVisible.value,
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.toggleConfirmPasswordVisibility();
                  },
                  icon: Icon(
                    controller.isConfirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppColors.greyColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),
            CustomButton(text: "Register", onPressed: () {
              controller.register(); 
            }),
          ],
        ),
      ),
    );
  }
}
