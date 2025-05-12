import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:jsulima/core/common/widgets/custom_button.dart' show CustomButton;
import 'package:jsulima/core/utils/constants/colors.dart' show AppColors;
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/auth/register/profile_setup/widgets/notched_corner_clipper.dart';
import 'package:jsulima/features/subscription/controller/subscription_controller.dart' show SubscriptionController;

class SubscriptionApplyCode extends StatelessWidget {
   SubscriptionApplyCode({super.key});

  final SubscriptionController controller = Get.find<SubscriptionController>();

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
        child: Padding(
          padding: EdgeInsets.only(
            top: 65, 
            left: 16, 
            right: 16, 
            bottom: 60
          ),
          child: Column(
            children: [
              Text("Promo Code", 
               style: getTextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
               ),
              ), 
              SizedBox(
                height: 20,
              ), 
              Expanded(
                child: ListView.builder(
                  itemCount: controller.prompList.length,
                  itemBuilder: (context, index) {
                    var promo = controller.prompList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 40, 
                        right: 40, 
                        bottom: 16
                      ),
                      child: Column(
                     
                        children: [
                          ClipPath(
                             clipper: NotchedCornerClipper(radius: 25, bottomRadius: 30),
                             child: Container(
                              width: double.infinity,
                              color: AppColors.primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 20, 
                                  left: 20, 
                                  right: 20, 
                                  bottom: 40, 
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(ImagePath.promo, 
                                     height: 40,
                                     width: 40,
                                    ), 
                                    SizedBox(
                                      height: 10,
                                    ), 
                                    Text(promo['name'], 
                                      style: getTextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                              )
                             ),
                          ),
                          SizedBox(
                            height: 5,
                          ), 
                          Container(
                            width: double.infinity,
                            decoration:  BoxDecoration(
                              color: Colors.white, 
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              )
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 20, 
                                    left: 20, 
                                    right: 20, 
                                    bottom: 20
                                  ),
                                   child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(promo['code'], 
                                      style: getTextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Save \$${promo['discount']} using this code",
                                       style: getTextStyle(
                                        color: Color(0xFF5B5760),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                       ),
                                      ),
                                    ],
                                   ),
                                ), 
                                Divider(
                                  color: Color(0xFFECE7F8),
                                  thickness: 1.8,
                                ), 
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8, 
                                    bottom: 20,
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      controller.discountPayment(controller.selectedPrice.toDouble(), (promo['discount'] as num).toDouble()); 
                                    },
                                    child: Text("Apply Code", 
                                     style: getTextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                     ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ); 
                  },
                  
                  ),
              ), 
             
              CustomButton(text: "Next", onPressed: (){
                controller.makePayment(controller.selectedPrice.toDouble()); 
              })
            ],
          )
          ,
        ),
      ),
    );
  }
}