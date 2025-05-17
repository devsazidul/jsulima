import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource, XFile;
import 'package:jsulima/core/services/end_points.dart' show Urls;
import 'package:jsulima/core/services/shared_preferences_helper.dart' show SharedPreferencesHelper;
import 'package:jsulima/features/auth/register/profile_setup/screens/select_preferred_game.dart' show SelectPreferredGame;
 

class ProfileSetupController extends GetxController {
   final RxString selectedImagePath = ''.obs;
   final RxString selectedGame = ''.obs;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  void toggleGameSelection(String game) {
    if (selectedGame.value == game) {
      selectedGame.value = '';  
    } else {
      selectedGame.value = game;  
    }
  }

  Future<void> uploadProfileImage() async {
    try {
      final String? token = await SharedPreferencesHelper.getAccessToken();
      if (token == null || selectedImagePath.value.isEmpty) {
        throw Exception('Token not found or image not selected.');
      }

      final uri = Uri.parse('${Urls.baseUrl}/users/upload-profile-image');

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..files.add(
          await http.MultipartFile.fromPath(
            'file',  
            selectedImagePath.value,
            filename: selectedImagePath.value.split('/').last,
          ),
        );

      final response = await request.send();

      if (response.statusCode == 200) {
                        
        final respStr = await response.stream.bytesToString();

        Get.to(() => SelectPreferredGame()); 
        if (kDebugMode) {
          print('Upload success: $respStr');
        }
      } else {
        // Failure
        final errorStr = await response.stream.bytesToString();
        if (kDebugMode) {
          print('Upload failed with status ${response.statusCode}: $errorStr');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Upload error: $e');
      }
    }
  }
}