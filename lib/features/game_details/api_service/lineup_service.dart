import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jsulima/core/services/end_points.dart';

class LineupService {
  Future<LineupResponse> getTeamLineup(String teamName) async {
    final url = Uri.parse(Urls.getLineupPlayer);
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
        if (jsonData['image_base64'] == null) {
          print('No image_base64 in API response!');
        } else {
          print('imageBase64 length: ${jsonData['image_base64'].length}');
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
    return LineupResponse(imageBase64: json['image_base64'] ?? '');
  }
}
