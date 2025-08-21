import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

class ForgotPasswordService {
  Future<Map<String, dynamic>> sendOtp(String email) async {
    final url = Uri.parse(Urls.forgotPassword);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": jsonDecode(response.body)};
      } else {
        return {
          "success": false,
          "message":
              jsonDecode(response.body)["message"] ?? "Something went wrong",
        };
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
