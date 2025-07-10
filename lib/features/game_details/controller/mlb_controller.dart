import 'package:get/get.dart';
import '../api_service/lineup_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../model/mlb_lineup_model.dart';

class MlbPlayerController extends GetxController {
  final RxString imageBase64 = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<MlbPlayer> players = <MlbPlayer>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Optionally fetch default team on init
    // fetchLineupAndImage('Boston Red Sox');
  }

  Future<void> fetchLineupAndImage(String teamName) async {
    isLoading.value = true;
    try {
      final lineupResponse = await LineupService().getTeamLineup(teamName);
      imageBase64.value = lineupResponse.imageBase64;
      players.value = lineupResponse.lineup;
    } catch (e) {
      EasyLoading.showError('Failed to fetch lineup');
    } finally {
      isLoading.value = false;
    }
  }
}
