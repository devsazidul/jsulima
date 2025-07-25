import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jsulima/core/services/end_points.dart';

class PlayerService {
  static final Map<String, Map<String, dynamic>> _cachedTopPerformers = {}; // In-memory cache for top performers

  Future<Map<String, dynamic>> fetchTopPerformers(
    String homeTeam,
    String awayTeam,
  ) async {
    final cacheKey = "$homeTeam:$awayTeam";
    if (kDebugMode) {
      debugPrint('PlayerService: Checking cache for key: $cacheKey');
    }

    // Check cache first
    if (_cachedTopPerformers.containsKey(cacheKey)) {
      if (kDebugMode) {
        debugPrint('PlayerService: Loaded top performers from cache for $cacheKey');
      }
      return _cachedTopPerformers[cacheKey]!;
    }

    // Cache miss, fetch from API
    if (kDebugMode) {
      debugPrint('PlayerService: Cache miss, starting API call for $cacheKey');
      debugPrint('PlayerService: URL: ${Urls.getTopPerformerNfl}');
      debugPrint('PlayerService: homeTeam: $homeTeam, awayTeam: $awayTeam');
    }

    final url = Uri.parse(Urls.getTopPerformerNfl);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'hometeam': homeTeam, 'awayteam': awayTeam}),
      );

      if (kDebugMode) {
        debugPrint('PlayerService: Response status code: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (kDebugMode) {
          debugPrint('PlayerService: API Response: $data');
        }

        // Cache the data
        _cachedTopPerformers[cacheKey] = data;
        if (kDebugMode) {
          debugPrint('PlayerService: Cached top performers for $cacheKey');
        }

        return data;
      } else {
        if (kDebugMode) {
          debugPrint('PlayerService: API call failed with status code: ${response.statusCode}');
        }
        throw Exception(
          'Failed to load top performers: Status ${response.statusCode}',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('PlayerService: Error fetching top performers: $e');
      }
      rethrow;
    }
  }
}