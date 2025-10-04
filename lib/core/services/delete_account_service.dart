import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';

class DeleteAccountService {
  static Future<bool> deleteAccount() async {
    try {
      EasyLoading.show(status: "Deleting account...");
      final token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || token.isEmpty) {
        EasyLoading.dismiss();
      }

      final response = await http.delete(
        Uri.parse(Urls.deleteAccount),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      EasyLoading.dismiss();

      if (response.statusCode == 200 || response.statusCode == 204) {
        EasyLoading.showSuccess("Account deleted successfully");
        return true;
      } else {
        final error = jsonDecode(response.body);
        EasyLoading.showError(error["message"] ?? "Failed to delete account");
        throw Exception(error["message"] ?? "Failed to delete account");
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Something went wrong");
      rethrow;
    }
  }
}
