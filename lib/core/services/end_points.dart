class Urls {
  static const String baseUrl = 'http://184.105.208.66:8000';
  static const String baseUrlAi = 'http://172.83.15.114:8000';

  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register/send-otp';
  static const String otpVerify = '$baseUrl/auth/register/verify-otp';
  static const String confirmPassword = '$baseUrl/auth/reset-password/confirm';
  static const String forgotPassword = '$baseUrl/auth/reset-password/send-otp';
  static const String forgotOtpVerify =
      '$baseUrl/auth/reset-password/verify-otp';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
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

  static const String getHeadToHeadPredictionMlb =
      '$baseUrlAi/predict/mlb/head-to-head-win-prediction';
  static const String getLineupMlb = '$baseUrlAi/predict/mlb/lineup';
  static const String getHeadToHeadMlb = '$baseUrlAi/predict/mlb/head_to_head';
  static const String getTopBatterPitcherMlb =
      '$baseUrlAi/predict/mlb/top_batter_pitcher';
  static const String getWinPercentagesMlb =
      '$baseUrlAi/predict/mlb/win-percentages';

  static const String getHeadToHeadPredictionNfl =
      '$baseUrlAi/predict/nfl/head-to-head-win-prediction';
  static const String getLineupNfl = '$baseUrlAi/predict/nfl/lineup';
  static const String getHeadToHeadNfl = '$baseUrlAi/predict/nfl/head_to_head';
  static const String getTopPerformerNfl =
      '$baseUrlAi/predict/nfl/top-performer';
  static const String getWinPercentagesNfl =
      '$baseUrlAi/predict/nfl/win-percentages';
}
