import 'package:flutter/material.dart';
import 'package:jsulima/app.dart';
import 'package:jsulima/core/services/stripe_services.dart' show StripeService;
import 'package:firebase_core/firebase_core.dart';
import 'package:jsulima/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StripeService.init();
  runApp(const Jsulima());
}