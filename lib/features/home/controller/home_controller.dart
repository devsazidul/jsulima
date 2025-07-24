import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/services/match_service_mlb.dart';
import 'package:jsulima/core/services/match_service_nfl.dart';

class HomeController extends GetxController {
  var winningPrediction = 60.obs;
  var aiConfidence = 90.obs;
  RxString selectedLeague = 'NFL'.obs;
  final mlbGames = <Map<String, dynamic>>[].obs; // Observable list for MLB games
  final isLoadingMlbGames = false.obs; // Track MLB loading state
  final MatchServiceMlb matchServiceMlb = MatchServiceMlb(); // MLB service instance
  final nflGames = <Map<String, dynamic>>[].obs; // Observable list for NFL games
  final isLoadingNflGames = false.obs; // Track NFL loading state
  final MatchServiceNfl matchServiceNfl = MatchServiceNfl(); // NFL service instance
  static List<Map<String, dynamic>> _cachedNflGames = []; // In-memory cache for NFL
  static List<Map<String, dynamic>> _cachedMlbGames = []; // In-memory cache for MLB

  @override
  void onInit() {
    super.onInit();
    _loadSelectedLeague();
  }

  Future<void> _loadSelectedLeague() async {
    if (kDebugMode) {
      print("Loading default league: NFL");
    }
    selectedLeague.value = 'NFL';
    _loadCachedNflGames();
    if (nflGames.isEmpty) {
      await fetchNflGames();
    }
  }

  void selectLeague(String league) {
    if (kDebugMode) {
      print("Selected league: $league");
    }
    selectedLeague.value = league;
    if (league == 'MLB') {
      if (mlbGames.isEmpty) {
        _loadCachedMlbGames();
        if (mlbGames.isEmpty) {
          fetchMlbGames();
        }
      }
    } else if (league == 'NFL') {
      if (nflGames.isEmpty) {
        _loadCachedNflGames();
        if (nflGames.isEmpty) {
          fetchNflGames();
        }
      }
    }
  }

  void _loadCachedNflGames() {
    if (_cachedNflGames.isNotEmpty) {
      nflGames.assignAll(_cachedNflGames);
      if (kDebugMode) {
        print("Loaded ${_cachedNflGames.length} NFL games from cache");
      }
    } else {
      if (kDebugMode) {
        print("No NFL games found in cache");
      }
    }
  }

  void _loadCachedMlbGames() {
    if (_cachedMlbGames.isNotEmpty) {
      mlbGames.assignAll(_cachedMlbGames);
      if (kDebugMode) {
        print("Loaded ${_cachedMlbGames.length} MLB games from cache");
      }
    } else {
      if (kDebugMode) {
        print("No MLB games found in cache");
      }
    }
  }

  Future<void> fetchNflGames() async {
    try {
      isLoadingNflGames.value = true;
      final games = await matchServiceNfl.fetchNFLGames();
      nflGames.assignAll(games); 
      _cachedNflGames = List.from(games); 
      if (kDebugMode) {
        print("Fetched and cached ${games.length} NFL games");
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

  Future<void> fetchMlbGames() async {
    try {
      isLoadingMlbGames.value = true;
      final games = await matchServiceMlb.fetchMLBGames();
      mlbGames.assignAll(games); 
      _cachedMlbGames = List.from(games); 
      if (kDebugMode) {
        print("Fetched and cached ${games.length} MLB games");
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
}