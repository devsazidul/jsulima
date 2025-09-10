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
  static const String paymentCheckout = '$baseUrl/payment/checkout';
  static const String getProfileInfo = '$baseUrl/users/profile';
  static const String updateProfileInfo = '$baseUrl/users/update-profile';
  static const String changePassword = '$baseUrl/auth/change-password';
  static const String googleLogin = '$baseUrl/auth/google-login';
  static const String notification = '$baseUrl/notifications';

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
