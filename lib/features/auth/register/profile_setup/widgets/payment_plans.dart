import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/utils/constants/icon_path.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/auth/register/profile_setup/controller/payment_controller.dart';
import 'package:jsulima/features/auth/register/profile_setup/screens/apply_code_payment_screen.dart' show ApplyCodePaymentScreen;

class PaymentPlans extends StatelessWidget {
  PaymentPlans({super.key});

  final PaymentController controller = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Obx(
        () { 
          return ListView.builder(
          padding: EdgeInsets.zero,  
          shrinkWrap: true,
          itemCount: controller.plans.length,
          itemBuilder: (context, index) {
            final subscription = controller.plans[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.12),
                      Colors.white.withValues(alpha: 0.04),
                      Colors.white.withValues(alpha: 0.07),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(IconPath.perYearPlan, height: 40, width: 40),
                      SizedBox(height: 20),
                      Text(
                        subscription.title ?? "",
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        subscription.description ?? "",
                        style: getTextStyle(
                          lineHeight: 10,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 32),
                      RichText(
                        text: TextSpan(
                          text: "\$${subscription.price.toString()}",
                          style: getTextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: "/${subscription.planType ?? ""}",
                              style: getTextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomButton(text: "Get Started", onPressed: (){
                        
                        Get.to(ApplyCodePaymentScreen()); 
                        controller.selectedPrice.value = (subscription.price as num).toDouble();
        
                      }),
        
                      SizedBox(
                        height: 20,
                      ), 
                      Divider(
                        color:  Colors.white.withValues(alpha: 0.16),
                      ), 
                      SizedBox(
                        height: 20,
                      ), 
                      Text("You will get", 
                       style: getTextStyle(
                        color: Colors.white, 
                        fontSize: 18, 
                        fontWeight: FontWeight.w500
                       ),
                      ), 
                      SizedBox(
                        height: 20,
                      ), 
                      ...List.generate(
                        (subscription.features as List).length,
                        (i) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                IconPath.checkMark,
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "${subscription.features?[i]}",
                                  
                                  style: GoogleFonts.poppins(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
         } ),
    );
  }
}
