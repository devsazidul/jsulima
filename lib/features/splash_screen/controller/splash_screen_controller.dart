import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:jsulima/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:jsulima/features/splash_screen/model/splash_profile_model.dart';
import 'package:jsulima/features/welcome_screen/screen/welcome_screen.dart';

class SplashScreenController extends GetxController {
  var isLoading = false.obs;
  var profile = Rxn<SplashProfileModel>();

  var isSubscribed = false.obs;

  // Fetch profile from API
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      String? token = await SharedPreferencesHelper.getAccessToken();

      final response = await http.get(
        Uri.parse(Urls.getProfileInfo),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        profile.value = SplashProfileModel.fromJson(data);
        isSubscribed.value = profile.value!.isSubscribed;

        if (kDebugMode) {
          print("The is subscribed value is ${isSubscribed.value}");
        }
        if (kDebugMode) {
          print(
            "The value of is subscribed in profile is ${profile.value!.isSubscribed}",
          );
        }
      } else {
        if (kDebugMode) {
          print("No data found");
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void checkIsLogin() async {
    Timer(const Duration(seconds: 3), () async {
      String? token = await SharedPreferencesHelper.getAccessToken();

      if (token != null) {
        Get.offAll(() => BottomNavbarScreen());
      } else {
        Get.offAll(() => WelcomeScreen());
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    checkIsLogin();
  }
}
