import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import '../model/mlb_lineup_model.dart';

class LineupService {
  Future<MlbLineupResponse> getTeamLineup(String teamName) async {
    final url = Uri.parse(Urls.getLineupMlb);
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'name': teamName}),
      );

      print("response.body: ${response.body}");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return MlbLineupResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load lineup: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching lineup: $e');
    }
  }
}
