import 'dart:io';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'
    as http_parser; // Import for MediaType
import 'package:image_picker/image_picker.dart'
    show ImagePicker, ImageSource, XFile;
import 'package:path/path.dart' as path;
import 'package:jsulima/core/services/end_points.dart' show Urls;
import 'package:jsulima/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:jsulima/features/auth/register/profile_setup/screens/select_preferred_game.dart'
    show SelectPreferredGame;

class ProfileSetupController extends GetxController {
  final RxString selectedImagePath = ''.obs;
  final RxString selectedGame = ''.obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024, // Reduce size
      imageQuality: 85, // Compress image
    );

    if (image != null) {
      selectedImagePath.value = image.path;
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  void toggleGameSelection(String game) {
    if (selectedGame.value == game) {
      selectedGame.value = '';
    } else {
      selectedGame.value = game;
      SharedPreferencesHelper.saveSelectedGame(game);
    }
  }

  Future<void> uploadProfileImage() async {
    try {
      final String? token = await SharedPreferencesHelper.getAccessToken();
      if (token == null) {
        Get.snackbar('Error', 'Authentication token not found');
        return;
      }
      if (selectedImagePath.value.isEmpty) {
        Get.snackbar('Error', 'Please select an image');
        return;
      }

      final uri = Uri.parse('${Urls.baseUrl}/users/upload-profile-image');
      final request =
          http.MultipartRequest('POST', uri)
            ..headers['Authorization'] = 'Bearer $token'
            ..headers['Accept'] = 'application/json';

      // Validate file
      final file = File(selectedImagePath.value);
      if (!await file.exists()) {
        Get.snackbar('Error', 'Selected image file does not exist');
        return;
      }

      final fileSize = await file.length();
      if (fileSize > 5 * 1024 * 1024) {
        // Limit to 5MB
        Get.snackbar('Error', 'Image file is too large (max 5MB)');
        return;
      }

      // Determine MIME type
      final extension = path.extension(selectedImagePath.value).toLowerCase();
      String mimeType = 'image/jpeg'; // Default
      if (extension == '.png') {
        mimeType = 'image/png';
      } else if (extension == '.jpg' || extension == '.jpeg') {
        mimeType = 'image/jpeg';
      } else {
        Get.snackbar('Error', 'Unsupported image format: $extension');
        return;
      }

      // Sanitize filename
      final fileName = path
          .basename(selectedImagePath.value)
          .replaceAll(RegExp(r'[^\w.]'), '_');

      // Add file with contentType
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // Must match server's expected field name
          selectedImagePath.value,
          filename: fileName,
          contentType: http_parser.MediaType.parse(mimeType),
        ),
      );

      // Log request details
      if (kDebugMode) {
        print('Uploading to: $uri');
        print('Headers: ${request.headers}');
        print('Files: ${request.files.map((f) => f.filename).toList()}');
        print('Fields: ${request.fields}');
        print('File: $fileName ($mimeType, Size: ${fileSize ~/ 1024} KB)');
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Upload success: $responseBody');
        }
        Get.snackbar('Success', 'Profile image uploaded successfully');
        Get.to(() => SelectPreferredGame());
      } else {
        if (kDebugMode) {
          print(
            'Upload failed with status ${response.statusCode}: $responseBody',
          );
        }
        Get.snackbar(
          'Error',
          'Failed to upload image: ${response.statusCode} - $responseBody',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Upload error: $e');
      }
      Get.snackbar('Error', 'Upload failed: $e');
    }
  }
}
