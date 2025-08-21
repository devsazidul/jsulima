import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

class ConfirmPasswordService {
  Future<bool> confirmPassword({
    required String email,
    required String newPassword,
  }) async {
    final Uri url = Uri.parse(Urls.confirmPassword);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "newPassword": newPassword}),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        if (kDebugMode) {
          print("Error: ${response.statusCode}, ${response.body}");
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception: $e");
      }
      return false;
    }
  }
}
