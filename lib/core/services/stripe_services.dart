import 'dart:convert';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/shared_preferences_helper.dart';
import 'package:jsulima/features/auth/register/profile_setup/controller/payment_controller.dart';

class StripeService {
  static Future<void> init() async {
    Stripe.publishableKey =
        'pk_test_51QxRa94Jkoj1g0MMEOAvSXFKAu0fO1xzlm8MkS3TMxgnusylmb2PZ1eKO9TYJ6IrrrC3h2KAJ3nXkF9USyrnIQ3c00wOsgmdi3';
    await Stripe.instance.applySettings();
  }

  static Future<void> makePayment(double amount, String currency) async {
    // get controller instance
    final PaymentController controller = Get.put(PaymentController());

    try {
      final int amountInCents = (amount * 100).toInt();
      final paymentIntent = await _createPaymentIntent(amountInCents, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Your App Name',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      // Handle successful payment here
      String? userId = await SharedPreferencesHelper.getUserId();
      String planId = controller.selectedPlanId.value;

      // controller.paymentCheckout(planId, amount.toInt());

      if (kDebugMode) {
        print('\$$amount payment successful');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Payment error: $e');
      }
    }
  }

  static Future<Map<String, dynamic>> _createPaymentIntent(
    int amount,
    String currency,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51QxRa94Jkoj1g0MMbGzYh9obtwJD38Q4ecilXIcx68MuU9Fd88HZpcMb6Sd2an1GVBfeo5pByWWh4X0EGjGIXHzr00T0m1EHdZ',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'amount': amount.toString(), 'currency': currency},
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception('Failed to create payment intent: $err');
    }
  }
}
