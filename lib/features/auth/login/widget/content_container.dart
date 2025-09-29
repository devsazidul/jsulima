import 'package:flutter/gestures.dart' show TapGestureRecognizer;
import 'package:flutter/material.dart'
    show
        Checkbox,
        CheckboxListTile,
        Colors,
        Divider,
        IconButton,
        Icons,
        ListTileControlAffinity,
        VisualDensity;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/common/widgets/custom_textfield.dart';
import 'package:jsulima/core/utils/constants/colors.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/auth/forgot_password/screen/forgot_pass_screen.dart';
import 'package:jsulima/features/auth/login/controller/login_screen_controller.dart';
import 'package:jsulima/features/auth/register/signup/screen/register_screen.dart';
import 'package:jsulima/features/welcome_screen/screen/welcome_screen.dart';
import 'package:jsulima/features/welcome_screen/widget/signinmethod.dart';

class ContentContainer extends StatelessWidget {
  ContentContainer({super.key});

  final LoginScreenController controller = Get.find<LoginScreenController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final verticalPadding = isLargeScreen ? 32.h : 24.h;
    final horizontalPadding = isLargeScreen ? 24.w : 12.w;
    final fontScale = isLargeScreen ? 1.2 : 1.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF393939),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: AlignmentGeometry.bottomLeft,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Get.offAll(WelcomeScreen());
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Login",
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 28.sp * fontScale,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: isLargeScreen ? 12.h : 8.h),
              Flexible(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 12.sp * fontScale,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: getTextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 12.sp * fontScale,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(() => RegisterScreen());
                              },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isLargeScreen ? 40.h : 30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: getTextStyle(
                    color: AppColors.greyColor,
                    fontSize: 12.sp * fontScale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: CustomTextField(
                  controller: controller.emailController,
                  hintText: "xyz@gmail.com",
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: getTextStyle(
                    color: AppColors.greyColor,
                    fontSize: 12.sp * fontScale,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: Obx(
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
                        size: isLargeScreen ? 24.sp : 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.isRememberMeChecked.value,
                          onChanged: (value) {
                            controller.toggleRememberMe();
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          visualDensity: VisualDensity.standard,
                        ),
                      ),
                      Text(
                        "Remember me",
                        style: getTextStyle(
                          color: AppColors.greyColor,
                          fontSize: 12.sp * fontScale,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ForgotPassScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      child: Text(
                        "Forgot Password?",
                        style: getTextStyle(
                          color: Color(0xFF4D81E7),
                          fontSize: 12.sp * fontScale,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Center(
                      child: IntrinsicWidth(
                        child: CheckboxListTile(
                          title: Text(
                            "Hide my email (use anonymous ID)",
                            style: TextStyle(
                              color: AppColors.greyColor,
                              fontSize: 12.sp * fontScale,
                            ),
                          ),
                          value: controller.isEmailPrivate.value,
                          onChanged: (value) => controller.toggleEmailPrivacy(),
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ),
                    ),
                  ),
                  // Obx(
                  //   () => Center(
                  //     child: IntrinsicWidth(
                  //       child: CheckboxListTile(
                  //         title: Text(
                  //           "Allow tracking for personalized ads",
                  //           style: TextStyle(
                  //             color: AppColors.greyColor,
                  //             fontSize: 12.sp * fontScale,
                  //           ),
                  //         ),
                  //         value: controller.isTrackingConsent.value,
                  //         onChanged:
                  //             (value) => controller.toggleTrackingConsent(),
                  //         activeColor: Colors.white,
                  //         checkColor: Colors.black,
                  //         controlAffinity: ListTileControlAffinity.leading,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 14.h),
              SizedBox(
                width: isLargeScreen ? 0.6.sw : double.infinity,
                child: CustomButton(
                  text: "Log In",
                  onPressed: () {
                    controller.login();
                  },
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColors.greyColor,
                      thickness: 1,
                      indent: isLargeScreen ? 20.w : 10.w,
                      endIndent: 5.w,
                    ),
                  ),
                  Text(
                    "OR",
                    style: getTextStyle(
                      color: AppColors.greyColor,
                      fontSize: 12.sp * fontScale,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColors.greyColor,
                      thickness: 1,
                      indent: 5.w,
                      endIndent: isLargeScreen ? 20.w : 10.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: isLargeScreen ? 0.6.sw : double.infinity,
                child: Signinmethod(
                  onTap: () {
                    controller.signInWithGoogle();
                  },
                  text: "Continue with Google",
                  image: ImagePath.signinWithGoogle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
