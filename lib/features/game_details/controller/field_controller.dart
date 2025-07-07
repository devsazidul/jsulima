import 'package:get/get.dart';
import 'package:jsulima/features/game_details/api_service/lineup_service_nfl.dart';

class FieldController extends GetxController {
  final RxString imageBase64 = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLineupAndImage('Arizona Cardinals', 'Atlanta Falcons');
  }

  Future<void> fetchLineupAndImage(String homeTeam, String awayTeam) async {
    isLoading.value = true;
    try {
      final lineupResponse = await LineupServiceNfl().getTeamLineup(homeTeam, awayTeam);
      imageBase64.value = lineupResponse.imageBase64;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch lineup: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
