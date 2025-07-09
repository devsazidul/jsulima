import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';
import '../model/head_to_head_model.dart';

class HeadToHeadService {
  Future<HeadToHeadModel> getHeadToHead({
    required String homeTeam,
    required String awayTeam,
  }) async {
    final url = Uri.parse(Urls.getHeadToHeadNfl);
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
        print('HeadToHead response: \n${response.body}');
      }
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return HeadToHeadModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load head-to-head: \n${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching head-to-head: $e');
    }
  }
}
