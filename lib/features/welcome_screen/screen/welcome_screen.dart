import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/services/auth_service.dart';
import 'package:jsulima/core/utils/constants/colors.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/auth/login/screen/login_screen.dart';
import 'package:jsulima/features/auth/register/signup/screen/register_screen.dart'
    show RegisterScreen;
import 'package:jsulima/features/welcome_screen/controller/welcome_screen_controller.dart'
    show WelcomeScreenController;
import 'package:jsulima/features/welcome_screen/widget/signinmethod.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final WelcomeScreenController controller = Get.put(WelcomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Text(
                  "Unleash the Power of AI in Sports",
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Predictions!",
                  style: getTextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 40),
                CustomButton(
                  text: "Login",
                  onPressed: () {
                    Get.offAll(() => LoginScreen());
                  },
                ),
                SizedBox(height: 16),
                CustomButton(
                  color: Colors.transparent,
                  textColor: AppColors.primaryColor,
                  text: "Sign Up",
                  onPressed: () {
                    Get.offAll(() => RegisterScreen());
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppColors.greyColor, thickness: 1),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "OR",
                      style: getTextStyle(
                        color: AppColors.greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Divider(color: AppColors.greyColor, thickness: 1),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Signinmethod(
                  onTap: () async {
                    final credential = await AuthService().signInWithGoogle();
                    if (credential.user != null) {
                      if (kDebugMode) {
                        print("Gmail: ${credential.user!.email}");
                      }
                    } else {
                      if (kDebugMode) {
                        print("Sign-in failed or no user data available");
                      }
                    }
                  },
                  text: "Continue with Google",
                  image: ImagePath.signinWithGoogle,
                ),
                // SizedBox(height: 16.h),
                // Signinmethod(
                //   color: Colors.white,
                //   textColor: Colors.black,
                //   onTap: () {},
                //   text: "Continue with Apple",
                //   image: ImagePath.signinWithApple,
                // ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
