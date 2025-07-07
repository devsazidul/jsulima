import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';

class HomeController extends GetxController {
  var winningPrediction = 60.obs;
  var aiConfidence = 90.obs;
  RxString selectedLeague = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSelectedLeague();
  }

  Future<void> _loadSelectedLeague() async {
    final savedLeague = await SharedPreferencesHelper.getSelectedGame();
    if (savedLeague != null && savedLeague.isNotEmpty) {
      selectedLeague.value = savedLeague;
      if (kDebugMode) {
        print("Loaded selected league from SharedPreferences: $savedLeague");
      }
    } else {
      if (kDebugMode) {
        print("No saved league found in SharedPreferences");
      }
    }
  }

  void selectLeague(String league) {
    if (kDebugMode) {
      print("Selected league: $league");
    }
    selectedLeague.value = league;
  }
}
