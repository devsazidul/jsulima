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
        EasyLoading.showError("Access token not found");
        return false;
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
        String errorMessage = "Failed to delete account";
        try {
          final error = jsonDecode(response.body);
          if (error["message"] != null) {
            errorMessage = error["message"];
          }
        } catch (_) {}
        EasyLoading.showError(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
      rethrow;
    }
  }
}
