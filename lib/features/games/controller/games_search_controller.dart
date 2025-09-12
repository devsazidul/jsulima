import 'package:get/get.dart';

class GamesSearchController extends GetxController {
  var searchQuery = ''.obs;
  var filteredNflGames = <Map<String, dynamic>>[].obs;
  var filteredMlbGames = <Map<String, dynamic>>[].obs;
  var allNflGames = <Map<String, dynamic>>[].obs;
  var allMlbGames = <Map<String, dynamic>>[].obs;

  void updateSearchQuery(String query) {
    searchQuery.value = query.toLowerCase();
    filterGames();
  }

  void filterGames() {
    if (searchQuery.value.isEmpty) {
      filteredNflGames.assignAll(allNflGames);
      filteredMlbGames.assignAll(allMlbGames);
    } else {
      filteredNflGames.assignAll(
        allNflGames.where((game) {
          final team1Name = (game['team1Name'] as String?)?.toLowerCase() ?? '';
          final team2Name = (game['team2Name'] as String?)?.toLowerCase() ?? '';
          return team1Name.contains(searchQuery.value) ||
              team2Name.contains(searchQuery.value);
        }).toList(),
      );

      filteredMlbGames.assignAll(
        allMlbGames.where((game) {
          final team1Name = (game['team1Name'] as String?)?.toLowerCase() ?? '';
          final team2Name = (game['team2Name'] as String?)?.toLowerCase() ?? '';
          return team1Name.contains(searchQuery.value) ||
              team2Name.contains(searchQuery.value);
        }).toList(),
      );
    }
  }

  void updateGameLists(
    List<Map<String, dynamic>> nflGames,
    List<Map<String, dynamic>> mlbGames,
  ) {
    allNflGames.assignAll(nflGames);
    allMlbGames.assignAll(mlbGames);
    filterGames();
  }

  void clearSearch() {
    searchQuery.value = '';
    filterGames();
  }
}
