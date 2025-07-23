import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/models/table_model.dart';
import 'package:jsulima/core/services/end_points.dart';

class TableService {
  Future<List<TableModel>> fetchTableData(String league) async {
    final String url = league == 'NFL' ? Urls.getWinPercentagesNfl : Urls.getWinPercentagesMlb;
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData.map((json) => TableModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}