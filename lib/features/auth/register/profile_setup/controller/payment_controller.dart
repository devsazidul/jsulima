import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/icon_path.dart';

class PaymentController extends GetxController {
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
}