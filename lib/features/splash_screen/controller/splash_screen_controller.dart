import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:jsulima/features/auth/register/profile_setup/screens/choose_your_plan_screen.dart'
    show ChooseYourPlanScreen;
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
      // String? subscriptionStatus =
      //     await SharedPreferencesHelper.getSubscriptionStatus();

      if (token != null) {
        if (isSubscribed.value == true) {
          Get.offAll(() => BottomNavbarScreen());
        } else {
          Get.offAll(() => ChooseYourPlanScreen());
        }
      } else {
        Get.offAll(() => WelcomeScreen());
      }

      // String? token = await SharedPreferencesHelper.getAccessToken();

      // String? userType = await SharedPreferencesHelper.getSelectedRole();

      // if (token != null) {

      //   if(userType == "SUBSCRIBER"){
      //      Get.offAll(() => SubscriberBottomNavbarView());
      //   }
      //   else{
      //     Get.offAll(() => UserBottomNavbarView());
      //   }

      // } else {
      //   Get.offAll(() => RoleSelectScreen());
      // }
    });
  }

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    checkIsLogin();
  }
}
