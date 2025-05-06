import 'package:get/get.dart';

class HomeController extends GetxController {
  var winningPrediction = 60.obs;
  var aiConfidence = 90.obs;
  var selectedLeague = 'NFL'.obs;

  void selectLeague(String league) {
    selectedLeague.value = league;
  }
}
