import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/services/match_service_mlb.dart';
import 'package:jsulima/core/services/match_service_nfl.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart';

class HomeController extends GetxController {
  var aiConfidence = 90.obs;
  RxString selectedLeague = 'NFL'.obs;
  final mlbGames = <Map<String, dynamic>>[].obs;
  final isLoadingMlbGames = false.obs;
  final MatchServiceMlb matchServiceMlb = MatchServiceMlb(); 
  final nflGames = <Map<String, dynamic>>[].obs; 
  final isLoadingNflGames = false.obs; 
  final MatchServiceNfl matchServiceNfl = MatchServiceNfl(); 

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
      if (savedLeague == 'MLB') {
        await fetchMlbGames();
      } else if (savedLeague == 'NFL') {
        await fetchNflGames();
      }
    } else {
      if (kDebugMode) {
        print("No saved league found in SharedPreferences");
      }
      await fetchNflGames();
    }
  }

  void selectLeague(String league) {
    if (kDebugMode) {
      print("Selected league: $league");
    }
    selectedLeague.value = league;
    if (league == 'MLB') {
      fetchMlbGames();
    } else if (league == 'NFL') {
      fetchNflGames();
    }
    SharedPreferencesHelper.saveSelectedGame(league);
  }

  Future<void> fetchMlbGames() async {
    try {
      isLoadingMlbGames.value = true;
      final games = await matchServiceMlb.fetchMLBGames();
      mlbGames.assignAll(games); 
      if (kDebugMode) {
        print("Fetched ${games.length} MLB games");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching MLB games: $e");
      }
      Get.snackbar('Error', 'Failed to load MLB games: $e');
    } finally {
      isLoadingMlbGames.value = false;
    }
  }

  Future<void> fetchNflGames() async {
    try {
      isLoadingNflGames.value = true;
      final games = await matchServiceNfl.fetchNFLGames();
      nflGames.assignAll(games); 
      if (kDebugMode) {
        print("Fetched ${games.length} NFL games");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching NFL games: $e");
      }
      Get.snackbar('Error', 'Failed to load NFL games: $e');
    } finally {
      isLoadingNflGames.value = false;
    }
  }
}