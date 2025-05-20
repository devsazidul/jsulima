import 'dart:convert';

import 'package:get/get.dart';
import 'package:jsulima/core/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';

class ProfileServices {
  Future<ProfileModel> getProfile() async {
    var token = await SharedPreferencesHelper.getAccessToken().toString();

    print("token: $token");
    if (token == null) {
      Get.snackbar('Error', 'Token is null');
      throw Exception('Token is null');
    }
    if (token == '') {
      Get.snackbar('Error', 'Token is empty');
      throw Exception('Token is empty');
    }
    try {
      final response = await http.get(
        Uri.parse(Urls.getProfileInfo),
        headers: {
          'Authorization':
              'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
        },
      );

      print("response: ${response.body}");
      print("status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProfileModel.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      print("profile error: $e");
      Get.snackbar('Error', 'Failed to fetch profile data: $e');
      rethrow;
    }
  }
}
