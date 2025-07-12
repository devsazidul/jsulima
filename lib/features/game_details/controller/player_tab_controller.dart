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
    final homePlayers = [
      if (apiData.value['home_team']?['top_batter'] != null)
        apiData.value['home_team']['top_batter'],
      if (apiData.value['home_team']?['top_pitcher'] != null)
        apiData.value['home_team']['top_pitcher'],
    ];
    final teams = PlayerModelMlb.mapPlayersToTeam(homePlayers);
    return teams.where((player) {
      return homeTeamFilter.value == 'batter'
          ? player['playerPosition'] != 'Pitcher'
          : player['playerPosition'] == 'Pitcher';
    }).toList();
  }

  List<Map<String, dynamic>> getFilteredAwayPlayers() {
    final awayPlayers = [
      if (apiData.value['away_team']?['top_batter'] != null)
        apiData.value['away_team']['top_batter'],
      if (apiData.value['away_team']?['top_pitcher'] != null)
        apiData.value['away_team']['top_pitcher'],
    ];
    final teams = PlayerModelMlb.mapPlayersToTeam(awayPlayers);
    return teams.where((player) {
      return awayTeamFilter.value == 'batter'
          ? player['playerPosition'] != 'Pitcher'
          : player['playerPosition'] == 'Pitcher';
    }).toList();
  }
}