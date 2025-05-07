import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var isNotificationEnabled = true.obs;

  void toggleNotification() {
    isNotificationEnabled.value = !isNotificationEnabled.value;
  }
}
