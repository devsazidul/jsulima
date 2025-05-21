import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart' show Urls;
import 'package:jsulima/core/services/shared_preferences_helper.dart';
import 'package:jsulima/core/services/stripe_services.dart';
import 'package:jsulima/core/utils/constants/icon_path.dart';
import 'package:jsulima/features/auth/register/profile_setup/model/plan_model.dart'
    show PlanModel;
import 'package:jsulima/features/auth/register/profile_setup/screens/webview_payment.dart';
import 'package:jsulima/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:jsulima/features/welcome_screen/screen/welcome_screen.dart';

class PaymentController extends GetxController {
  var selectedPrice = 0.0.obs;
  RxString selectedPlanId = ''.obs;

  final List<Map<String, dynamic>> subscriptionList = [
    {
      "name": "Premium Plan",
      "description":
          "Users who want complete access to all match predictions, performance data, and a premium experience.",
      "price": 99,
      "limit": "per month",
      "icon": IconPath.perMonthPlan,
      "included": [
        "Unlimited AI Predictions for all upcoming matches",
        "Detailed Prediction Accuracy Stats",
        "Advanced Player Performance Predictions",
        "Access to Historical Data",
        "Progress Tracking",
        "Exclusive Match Insights and team/player analytics",
      ],
    },
    {
      "name": "Premium Plan",
      "description":
          "Users who want complete access to all match predictions, performance data, and a premium experience.",
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
    {"name": "Flat \$25 off", "code": "Prediction25", "discount": 25},
  ];

  void makePayment(double amount) {
    StripeService.makePayment(amount, "usd");
  }

  void makeWebPayment(double amount, String planId, BuildContext context) {
    paymentCheckout(context, planId, amount.toInt());
  }

  void discountPayment(double amount, double discount) {
    var discountedAmount = amount - (amount * (discount / 100));
    StripeService.makePayment(discountedAmount, "usd");
  }

  void getBacktoLogin() {
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
      EasyLoading.show(status: "Loading...");

      isLoading.value = true;
      final response = await http.get(Uri.parse('${Urls.baseUrl}/plans'));

      print("The plan datas are ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        plans.value = data.map((e) => PlanModel.fromJson(e)).toList();
      } else {
        EasyLoading.showError("Something went wrong");
        print("Failed to fetch plans. Status code: ${response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong");
      print("The error is $e");
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  // Function to handle payment checkout
  Future<void> paymentCheckout(
    BuildContext context,
    String planId,
    int amount,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${Urls.paymentCheckout}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
        },
        body: jsonEncode({'planId': planId, 'amount': amount}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        String url = data['url'];

        Get.to(() => PaymentWebViewScreen(paymentUrl: url));

        if (kDebugMode) {
          print("Payment checkout successful: $url");
        }
      } else {
        if (kDebugMode) {
          print("Payment checkout failed. Status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during payment checkout: $e");
      }
    }
  }
}
