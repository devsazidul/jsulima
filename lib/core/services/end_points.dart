class Urls {
  static const String baseUrl = 'https://jsulima-backend.onrender.com';
  static const String baseUrlAi = 'https://game-api-ai.onrender.com';

  static const String login = '$baseUrl/auth/login';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
  static const String forgotPass = '$baseUrl/auth/forgot-password';
  static const String pickUpLocation = '$baseUrl/user/pickup-locations';
  static String getCalendar(String date, String locationUuid) =>
      '$baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';
  static const String userProjectDetails = '$baseUrl/projects';
  static const String tasks = '$baseUrl/tasks';
  static const String profile = '$baseUrl/profile/';
  static const String portfolios = '$baseUrl/portfolios/';
  static const String socialMedia = '$baseUrl/socialAccount/all/social';
  static const String updateprotfolio = '$baseUrl/portfolios';
  static const String profileupdate = '$baseUrl/users/me';
  static const String authorizePayment = '$baseUrl/payment/authorize-payment';
  static const String capturePayment = '$baseUrl/payment/capture-payment';
  static const String notifications = '$baseUrl/notifications';
  static const String paymentCheckout = '$baseUrl/payment/checkout';
  static const String getProfileInfo = '$baseUrl/users/profile';  
  static const String updateProfileInfo = '$baseUrl/users/update-profile';


  static const String getLineupPlayer = '$baseUrlAi/predict/mlb/lineup';
  static const String getLineupPlayerNfl = '$baseUrlAi/predict/nfl/lineup';
  static const String getHeadToHeadNfl = '$baseUrlAi/predict/nfl/head_to_head';
  static const String getHeadToHeadMlb = '$baseUrlAi/predict/mlb/head_to_head';
}
