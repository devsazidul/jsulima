import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jsulima/core/services/end_points.dart';

class NotificationController extends GetxController {
  var selectedButton = 0.obs;
  var notifications = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  final String baseUrl = Urls.notification;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void onButtonClick(int buttonIndex) {
    selectedButton.value = buttonIndex;

    if (buttonIndex == 0) {
      fetchNotifications();
    } else if (buttonIndex == 1) {
      fetchNotifications(league: "NFL");
    } else if (buttonIndex == 2) {
      fetchNotifications(league: "MLB");
    }
  }

  Future<void> fetchNotifications({String? league}) async {
    try {
      isLoading.value = true;
      String url = baseUrl;
      if (league != null) {
        url = "$baseUrl?league=$league";
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        notifications.value =
            data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        notifications.clear();
      }
    } catch (e) {
      notifications.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
