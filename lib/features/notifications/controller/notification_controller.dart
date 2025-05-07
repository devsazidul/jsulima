import 'package:get/get.dart';

class NotificationController extends GetxController {
  var selectedButton = 0.obs;

  void onButtonClick(int buttonIndex) {
    selectedButton.value = buttonIndex;
  }
}
