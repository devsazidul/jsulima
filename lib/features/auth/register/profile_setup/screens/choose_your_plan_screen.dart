import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/utils/constants/colors.dart' show AppColors;

import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/auth/register/profile_setup/controller/payment_controller.dart';
import 'package:jsulima/features/auth/register/profile_setup/widgets/payment_plans.dart'
    show PaymentPlans;

class ChooseYourPlanScreen extends StatelessWidget {
  ChooseYourPlanScreen({super.key});

  final PaymentController controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 65, left: 16, right: 16, bottom: 60),
            child: Column(
              children: [
                Text(
                  "Choose Your Plan",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PaymentPlans(),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Back to the ',
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: getTextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                controller.getBacktoLogin(); 
                              },
                      ),
                      TextSpan(
                        text: ' Screen',
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
