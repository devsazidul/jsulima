import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

class OtpService {
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    final url = Uri.parse(Urls.forgotOtpVerify);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      // Safely decode body (might be empty or not JSON)
      Map<String, dynamic>? body;
      try {
        body = response.body.isNotEmpty ? jsonDecode(response.body) : null;
      } catch (_) {
        body = null;
      }

      final isSuccess = response.statusCode >= 200 && response.statusCode < 300;
      final message =
          (body != null && body["message"] is String)
              ? body["message"] as String
              : (isSuccess
                  ? "OTP verified successfully"
                  : "Something went wrong");

      return {"ok": isSuccess, "message": message, "code": response.statusCode};
    } catch (e) {
      return {"ok": false, "message": e.toString()};
    }
  }
}
