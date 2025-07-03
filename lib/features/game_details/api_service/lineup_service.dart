import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

import '../model/lineup_player_model.dart';

class LineupService {
  Future<LineupResponse> getTeamLineup(String teamName) async {
    final url = Uri.parse('${Urls.getLineupPlayer}$teamName');
    try {
      final response = await http.post(
        url,
        headers: {'Accept': 'application/json'},
        body: jsonEncode({'team_name': teamName}),
      );

      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return LineupResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load lineup: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching lineup: $e');
    }
  }
}
