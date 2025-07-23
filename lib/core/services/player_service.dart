import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jsulima/core/services/end_points.dart';

class PlayerService {
  Future<Map<String, dynamic>> fetchTopPerformers(
    String homeTeam,
    String awayTeam,
  ) async {
    final url = Uri.parse(Urls.getTopPerformerNfl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'hometeam': homeTeam, 'awayteam': awayTeam}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('API Response: $data');
        return data;
      } else {
        throw Exception(
          'Failed to load top performers: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching top performers: $e');
      rethrow;
    }
  }
}
