import 'package:flutter/material.dart' show Colors, IconButton, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/common/widgets/custom_textfield.dart';
import 'package:jsulima/core/utils/constants/colors.dart';
import 'package:jsulima/features/auth/login/controller/login_screen_controller.dart';

class ContentContainer extends StatelessWidget {
   ContentContainer({super.key});

  final LoginScreenController controller = Get.find<LoginScreenController>(); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        color: Color(0xFF393939), 
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12, 
          vertical: 24
        ), 
        child: Column(
          children: [
            Text("Login",
             style: getTextStyle(
              color: Colors.white, 
              fontSize: 28.sp, 
              fontWeight: FontWeight.w600
             ),
            ), 
            SizedBox(
              height: 8,
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: getTextStyle(
                  color: Colors.white, 
                  fontSize: 12.sp, 
                  fontWeight: FontWeight.w400
                ),
                children: [
                  TextSpan(
                    text: "Sign Up",
                    style: getTextStyle(
                      color: AppColors.primaryColor, 
                      fontSize: 12.sp, 
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              
            ),
            SizedBox(
              height: 30,
            ), 
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: getTextStyle(
                  color: AppColors.greyColor, 
                  fontSize: 12.sp, 
                  fontWeight: FontWeight.w500
                ),
              ),
            ), 
            SizedBox(
              height: 10,
            ),
            CustomTextField(controller: controller.emailController, hintText: "xyz@gmail.com",),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: getTextStyle(
                  color: AppColors.greyColor, 
                  fontSize: 12.sp, 
                  fontWeight: FontWeight.w500 
                ),
              ),  
                ), 
            SizedBox(
              height: 10,
            ),
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
          ],
        ),
      ),
    );
  }
}