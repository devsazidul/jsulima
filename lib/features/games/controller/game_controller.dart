import 'package:get/get.dart';

import '../../game_details/api_service/lineup_service.dart';
import '../../game_details/model/lineup_player_model.dart';

class GameController extends GetxController {
  var selectedButton = 0.obs;
  LineupResponse? lineupResponse;

  void onButtonClick(int buttonIndex) {
    selectedButton.value = buttonIndex;
  }

  void fetchLineup(String teamName) async {
    final LineupService _lineupService = LineupService();

    try {
      final lineup = await _lineupService.getTeamLineup(teamName);
      lineupResponse = lineup;
    } catch (e) {
      print('Error fetching lineup: $e');
    }
  }
}
