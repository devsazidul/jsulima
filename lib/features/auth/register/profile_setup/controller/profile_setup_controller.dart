import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource, XFile;

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
}