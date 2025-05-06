
import 'package:get/get.dart';
import 'package:jsulima/features/auth/login/screen/login_screen.dart';
import 'package:jsulima/features/splash_screen/view/splash_screen.dart';



class AppRoute {
  static String splashScreen = '/splashScreen';
  static String forgetPasswordScreen = '/forgetPasswordScreen';
  static String signupScreen = '/signupScreen';
  static String signinScreen = '/signinScreen';
  static String bottomNavbarScreen = '/bottomNavbarScreen';

  static String getSplashScreen() => splashScreen;
  static String getForgetPasswordScreen() => forgetPasswordScreen;
  static String getsignupScreen() => signupScreen;
  static String getsigninScreen() => signinScreen;
  static String getbottomNavbarScreen() => bottomNavbarScreen;

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () =>  SplashScreen()),
     GetPage(name: signupScreen, page: () =>  LoginScreen()),
    // GetPage(name: signinScreen, page: () =>  LoginView()),
    // GetPage(name: forgetPasswordScreen, page: () =>  ForgetPasswordView()),
  
  ];
}