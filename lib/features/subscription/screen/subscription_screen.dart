import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/subscription/controller/subscription_controller.dart';
import 'package:jsulima/features/subscription/model/plan.dart';
import 'package:jsulima/features/subscription/widgets/plan_container.dart';
import 'package:jsulima/features/subscription/widgets/subscription_list.dart'
    show SubscriptionList;

class SubscriptionScreen extends StatelessWidget {
  Future<Plan> loadPlan() async {
    String jsonString = await rootBundle.loadString('assets/plans.json');
    final jsonResponse = json.decode(jsonString);
    return Plan.fromJson(jsonResponse);
  }

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
                FutureBuilder<Plan>(
                  future: loadPlan(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(height: 24);
                    }
                    final plan = snapshot.data!;
                    return Center(
                      child: PlanContainer(
                        planName: plan.planName,
                        price: plan.price,
                        planTime: plan.planTime,
                      ),
                    );
                  },
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
