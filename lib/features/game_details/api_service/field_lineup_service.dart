import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/features/game_details/model/field_lineup_model.dart';

class FieldLineupService {
  Future<FieldLineupResponse> getFieldLineup(
    String homeTeam,
    String awayTeam,
  ) async {
    if (kDebugMode) {
      print('FieldLineupService: Starting API call');
      print('FieldLineupService: URL: ${Urls.getLineupNfl}');
      print('FieldLineupService: homeTeam: $homeTeam, awayTeam: $awayTeam');
    }

    final url = Uri.parse(Urls.getLineupNfl);
    try {
      final requestBody = {'hometeam': homeTeam, 'awayteam': awayTeam};
      if (kDebugMode) {
        print('FieldLineupService: Request body: ${jsonEncode(requestBody)}');
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
        print(
          'FieldLineupService: Response status code: ${response.statusCode}',
        );
        print('FieldLineupService: Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (kDebugMode) {
          print(
            'FieldLineupService: Parsed JSON data keys: ${jsonData.keys.toList()}',
          );
          print(
            'FieldLineupService: home_players count: ${(jsonData['home_players'] as List<dynamic>?)?.length ?? 0}',
          );
          print(
            'FieldLineupService: away_players count: ${(jsonData['away_players'] as List<dynamic>?)?.length ?? 0}',
          );
          print(
            'FieldLineupService: lineup_image length: ${(jsonData['lineup_image'] as String?)?.length ?? 0}',
          );
        }

        final fieldLineupResponse = FieldLineupResponse.fromJson(jsonData);
        if (kDebugMode) {
          print('FieldLineupService: Successfully created FieldLineupResponse');
          print(
            'FieldLineupService: Response homePlayers count: ${fieldLineupResponse.homePlayers.length}',
          );
          print(
            'FieldLineupService: Response awayPlayers count: ${fieldLineupResponse.awayPlayers.length}',
          );
          print(
            'FieldLineupService: Response lineupImage length: ${fieldLineupResponse.lineupImage.length}',
          );
        }

        return fieldLineupResponse;
      } else {
        if (kDebugMode) {
          print(
            'FieldLineupService: API call failed with status code: ${response.statusCode}',
          );
        }
        throw Exception('Failed to load field lineup: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FieldLineupService: Exception occurred: $e');
      }
      throw Exception('Error fetching field lineup: $e');
    }
  }
}
