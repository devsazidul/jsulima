import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/subscription/controller/subscription_controller.dart';
import 'package:jsulima/features/subscription/widgets/subscription_list.dart' show SubscriptionList;

class SubscriptionScreen extends StatelessWidget {
   SubscriptionScreen({super.key});

  final SubscriptionController controller = Get.put(SubscriptionController());

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
            padding: EdgeInsets.only(top: 65, left: 16, right: 16, bottom: 40),
            child: Column(
              children: [
                Text(
                  "Subscription",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ), 
               SubscriptionList(), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}