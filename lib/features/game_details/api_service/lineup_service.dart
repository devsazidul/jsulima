import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import '../model/mlb_lineup_model.dart';

class LineupService {
  static final Map<String, MlbLineupResponse> _cachedTeamLineups = {}; // In-memory cache for MLB team lineups

  Future<MlbLineupResponse> getTeamLineup(String teamName) async {
    if (kDebugMode) {
      print('LineupService: Checking cache for team: $teamName');
    }

    // Check cache first
    if (_cachedTeamLineups.containsKey(teamName)) {
      if (kDebugMode) {
        print('LineupService: Loaded lineup from cache for $teamName');
      }
      return _cachedTeamLineups[teamName]!;
    }

    // Cache miss, fetch from API
    if (kDebugMode) {
      print('LineupService: Cache miss, starting API call for $teamName');
      print('LineupService: URL: ${Urls.getLineupMlb}');
    }

    final url = Uri.parse(Urls.getLineupMlb);
    try {
      final requestBody = {'name': teamName};
      if (kDebugMode) {
        print('LineupService: Request body: ${jsonEncode(requestBody)}');
      }

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (kDebugMode) {
        print('LineupService: Response status code: ${response.statusCode}');
        print('LineupService: Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final lineupResponse = MlbLineupResponse.fromJson(jsonData);

        // Cache the data
        _cachedTeamLineups[teamName] = lineupResponse;
        if (kDebugMode) {
          print('LineupService: Cached lineup for $teamName');
        }

        return lineupResponse;
      } else {
        if (kDebugMode) {
          print('LineupService: API call failed with status code: ${response.statusCode}');
        }
        throw Exception('Failed to load lineup: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('LineupService: Exception occurred: $e');
      }
      throw Exception('Error fetching lineup: $e');
    }
  }
}