import 'package:get/get.dart';
import 'package:jsulima/core/models/player_model_mlb.dart';
import 'package:jsulima/core/services/player_service_mlb.dart';
import 'package:flutter/foundation.dart';

class PlayerTabController extends GetxController {
  final RxString homeTeamFilter = 'batter'.obs;
  final RxString awayTeamFilter = 'batter'.obs;
  final Rx<Map<String, dynamic>> apiData = Rx<Map<String, dynamic>>({});
  final RxBool isLoading = true.obs;
  final RxString error = ''.obs;

  Future<void> fetchTopPerformers(String team1Name, String team2Name) async {
    try {
      isLoading.value = true;
      error.value = '';
      final data = await PlayerServiceMlb().fetchTopPerformers(team1Name, team2Name);
      if (!data.containsKey('home_team') || !data.containsKey('away_team')) {
        debugPrint('Invalid data format: home_team or away_team key not found in $data');
        error.value = 'Invalid data format: Missing team information';
        return;
      }
      apiData.value = data;
    } catch (e) {
      debugPrint('Error fetching top performers: $e');
      error.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void setHomeTeamFilter(String filter) {
    homeTeamFilter.value = filter;
  }

  void setAwayTeamFilter(String filter) {
    awayTeamFilter.value = filter;
  }

  List<Map<String, dynamic>> getFilteredHomePlayers() {
    final homeTeamData = apiData.value['home_team'];
    if (homeTeamData == null) return [];

    final player = homeTeamFilter.value == 'batter'
        ? homeTeamData['top_batter']
        : homeTeamData['top_pitcher'];

    if (player == null) return [];

    final mappedPlayer = PlayerModelMlb.mapPlayersToTeam([player]);
    return mappedPlayer;
  }

  List<Map<String, dynamic>> getFilteredAwayPlayers() {
    final awayTeamData = apiData.value['away_team'];
    if (awayTeamData == null) return [];

    final player = awayTeamFilter.value == 'batter'
        ? awayTeamData['top_batter']
        : awayTeamData['top_pitcher'];

    if (player == null) return [];

    final mappedPlayer = PlayerModelMlb.mapPlayersToTeam([player]);
    return mappedPlayer;
  }
}