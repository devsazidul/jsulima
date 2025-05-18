import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart' show Urls;
import 'package:jsulima/core/services/shared_preferences_helper.dart';
import 'package:jsulima/core/services/stripe_services.dart';
import 'package:jsulima/core/utils/constants/icon_path.dart';
import 'package:jsulima/features/auth/register/profile_setup/model/plan_model.dart' show PlanModel;
import 'package:jsulima/features/welcome_screen/screen/welcome_screen.dart';

class PaymentController extends GetxController {
  var selectedPrice = 0.0.obs; 
  final List<Map<String, dynamic>> subscriptionList = [
    {
      "name": "Premium Plan",
      "description": "Users who want complete access to all match predictions, performance data, and a premium experience.", 
      "price": 99,
      "limit": "per month",
      "icon": IconPath.perMonthPlan, 
      "included": [
        "Unlimited AI Predictions for all upcoming matches",
        "Detailed Prediction Accuracy Stats",
        "Advanced Player Performance Predictions", 
        "Access to Historical Data",
        "Progress Tracking",
        "Exclusive Match Insights and team/player analytics"
      ],
    },
    {
      "name": "Premium Plan",
      "description": "Users who want complete access to all match predictions, performance data, and a premium experience.", 
      "price": 999,
      "limit": "per year",
      "icon": IconPath.perYearPlan, 
      "included": [
        "Unlimited AI Predictions for all upcoming matches",
        "Detailed Prediction Accuracy Stats",
        "Advanced Player Performance Predictions", 
        "Access to Historical Data", 
        "Generate Custom Mock Interview", 
        "Exclusive Match Insights and team/player analytics", 
      ],
    },
  ];

  List<Map<String, dynamic>> prompList = [
     {
      "name" : "Flat \$25 off", 
      "code" : "Prediction25", 
      "discount" : 25,
     }
  ]; 

  void makePayment(double amount) {
      StripeService.makePayment(amount, "usd"); 
  }

  void discountPayment(double amount, double discount) {
    var discountedAmount = amount - (amount * (discount / 100));
    StripeService.makePayment(discountedAmount, "usd"); 
  }

  void getBacktoLogin(){
    SharedPreferencesHelper.clearAllData();
    Get.offAll(() => WelcomeScreen());
  }


  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  var plans = <PlanModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchPlans() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse('${Urls.baseUrl}/plans'));

      print("The plan datas are ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        plans.value = data.map((e) => PlanModel.fromJson(e)).toList();
      } else {
        print("Failed to fetch plans. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("The error is $e"); 
    } finally {
      isLoading.value = false;
    }
  }
}