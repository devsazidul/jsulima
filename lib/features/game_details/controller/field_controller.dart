import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/api_service/lineup_service_nfl.dart';

class FieldController extends GetxController {
  final RxString imageBase64 = ''.obs;
  final RxBool isLoading = false.obs;


  Future<void> fetchLineupAndImage(String homeTeam, String awayTeam) async {
    isLoading.value = true;
    try {
      final lineupResponse = await LineupServiceNfl().getTeamLineup(
        homeTeam,
        awayTeam,
      );
      imageBase64.value = lineupResponse.imageBase64;
    } catch (e) {
      EasyLoading.showError('Failed to fetch lineup.');
    } finally {
      isLoading.value = false;
    }
  }
}
