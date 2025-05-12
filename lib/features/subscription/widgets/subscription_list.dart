import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:jsulima/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:jsulima/core/common/widgets/custom_button.dart' show CustomButton;
import 'package:jsulima/core/utils/constants/icon_path.dart' show IconPath;
import 'package:jsulima/features/subscription/controller/subscription_controller.dart';
import 'package:jsulima/features/subscription/widgets/subscription_apply_code.dart' show SubscriptionApplyCode;

class SubscriptionList extends StatelessWidget {
   SubscriptionList({super.key});

  final SubscriptionController controller = Get.find<SubscriptionController>(); 

  @override
  Widget build(BuildContext context) {
     return SizedBox(
      height: 1800,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.subscriptionList.length,
        itemBuilder: (context, index) {
          final subscription = controller.subscriptionList[index];
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
                    Image.asset(subscription['icon'], height: 40, width: 40),
                    SizedBox(height: 20),
                    Text(
                      subscription['name'],
                      style: getTextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      subscription['description'],
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
                        text: "\$${subscription['price']}",
                        style: getTextStyle(
                          color: Colors.white,
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "/${subscription['limit']}",
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
                      
                    Get.to(SubscriptionApplyCode()); 
                      controller.selectedPrice.value = (subscription['price'] as num).toDouble();

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
                      (subscription['included'] as List).length,
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
                                "${subscription['included'][i]}",
                                
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
      ),
    );
  }
}