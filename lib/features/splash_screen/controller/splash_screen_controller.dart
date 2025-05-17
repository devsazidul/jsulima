import 'dart:async';

import 'package:get/get.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart' show SharedPreferencesHelper;
import 'package:jsulima/features/auth/register/profile_setup/screens/choose_your_plan_screen.dart' show ChooseYourPlanScreen;
import 'package:jsulima/features/bottom_navbar/screen/bottom_navbar_screen.dart';
import 'package:jsulima/features/welcome_screen/screen/welcome_screen.dart';


class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 3), () async {
      
      String? token = await SharedPreferencesHelper.getAccessToken();
      String? subscriptionStatus = await SharedPreferencesHelper.getSubscriptionStatus();

      if(token != null){
        if(subscriptionStatus != null){
          Get.offAll(() => BottomNavbarScreen()); 
        }
        else{
          Get.offAll(() => ChooseYourPlanScreen());
        } 
      } else{
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
    checkIsLogin();
  }
}