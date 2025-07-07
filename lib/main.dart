import 'package:flutter/material.dart';
import 'package:jsulima/app.dart';
import 'package:jsulima/core/services/stripe_services.dart' show StripeService;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StripeService.init();
  runApp(const Jsulima());
}
// avijitavi338895@gmail.com
// avijitdas