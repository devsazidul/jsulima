import 'package:get/get.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';

class HomeController extends GetxController {
  var winningPrediction = 60.obs;
  var aiConfidence = 90.obs;
  var selectedLeague = SharedPreferencesHelper.getSelectedGame().toString().obs;

  void selectLeague(String league) {
    selectedLeague.value = league;
  }
}
