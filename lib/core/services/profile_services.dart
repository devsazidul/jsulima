import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jsulima/core/models/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';

class ProfileServices {
  Future<ProfileModel> getProfile() async {
    var token = SharedPreferencesHelper.getAccessToken().toString();

    if (kDebugMode) {
      print("token: $token");
    }
    if (token == '') {
      EasyLoading.showError('Token is empty');
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

      if (kDebugMode) {
        print("response: ${response.body}");
      }
      if (kDebugMode) {
        print("status code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProfileModel.fromJson(data);
      } else {
        EasyLoading.showError('Failed to fetch profile data');
        throw Exception('Failed to load profile data');
      }
    } catch (e) {
      if (kDebugMode) {
        print("profile error: $e");
      }
      EasyLoading.showError('Failed to fetch profile data.');
      rethrow;
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updatedFields) async {
    var token = SharedPreferencesHelper.getAccessToken().toString();

    if (kDebugMode) {
      print("update token: $token");
      print("updated fields: $updatedFields");
    }
    if (token == '') {
      EasyLoading.showError('Token is empty');
      throw Exception('Token is empty');
    }
    try {
      final response = await http.patch(
        Uri.parse(Urls.updateProfileInfo), 
        headers: {
          'Authorization': 'Bearer ${await SharedPreferencesHelper.getAccessToken()}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedFields),
      );

      if (kDebugMode) {
        print("update response: ${response.body}");
        print("update status code: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Profile updated successfully');
      } else {
        EasyLoading.showError('Failed to update profile');
        throw Exception('Failed to update profile: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("update profile error: $e");
      }
      EasyLoading.showError('Failed to update profile.');
      rethrow;
    }
  }
}