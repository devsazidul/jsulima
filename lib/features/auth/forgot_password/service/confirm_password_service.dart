import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

class ConfirmPasswordService {
  Future<bool> confirmPassword({
    required String email,
    required String newPassword,
  }) async {
    final Uri url = Uri.parse(Urls.forgotPassword);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "newPassword": newPassword}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
