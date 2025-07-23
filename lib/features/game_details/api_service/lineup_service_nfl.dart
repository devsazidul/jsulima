import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

class LineupServiceNfl {
  Future<LineupResponse> getTeamLineup(String homeTeam, String awayTeam) async {
    final url = Uri.parse(Urls.getLineupNfl);
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'hometeam': homeTeam, 'awayteam': awayTeam}),
      );

      if (kDebugMode) {
        print("response.body: ${response.body}");
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['lineup_image'] == null) {
          if (kDebugMode) {
            print('No image_base64 in API response!');
          }
        } else {
          if (kDebugMode) {
            print('imageBase64 length: ${jsonData['lineup_image'].length}');
          }
        }
        return LineupResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load lineup: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching lineup: $e');
    }
  }
}

class LineupResponse {
  final String imageBase64;

  LineupResponse({required this.imageBase64});

  factory LineupResponse.fromJson(Map<String, dynamic> json) {
    return LineupResponse(imageBase64: json['lineup_image'] ?? '');
  }
}
