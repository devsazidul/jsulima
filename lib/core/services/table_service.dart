import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsulima/core/models/table_model.dart';
import 'package:jsulima/core/services/end_points.dart';

class TableService {
  static List<TableModel> _cachedNflTableData = []; 
  static List<TableModel> _cachedMlbTableData = []; 

  Future<List<TableModel>> fetchTableData(String league) async {
    final String url = league == 'NFL' ? Urls.getWinPercentagesNfl : Urls.getWinPercentagesMlb;

    // Check cache first
    if (league == 'NFL' && _cachedNflTableData.isNotEmpty) {
      if (kDebugMode) {
        print("Loaded ${_cachedNflTableData.length} NFL table data from cache");
      }
      return _cachedNflTableData;
    } else if (league == 'MLB' && _cachedMlbTableData.isNotEmpty) {
      if (kDebugMode) {
        print("Loaded ${_cachedMlbTableData.length} MLB table data from cache");
      }
      return _cachedMlbTableData;
    }

    // Cache miss, fetch from API
    try {
      if (kDebugMode) {
        print("Fetching table data for $league from API");
      }
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final tableData = jsonData.map((json) => TableModel.fromJson(json)).toList();
        
        // Cache the data
        if (league == 'NFL') {
          _cachedNflTableData = List.from(tableData);
          if (kDebugMode) {
            print("Cached ${tableData.length} NFL table data");
          }
        } else {
          _cachedMlbTableData = List.from(tableData);
          if (kDebugMode) {
            print("Cached ${tableData.length} MLB table data");
          }
        }
        
        return tableData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching $league table data: $e");
      }
      throw Exception('Error fetching data: $e');
    }
  }
}