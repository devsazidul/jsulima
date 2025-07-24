import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jsulima/core/models/match_model_mlb.dart';
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'dart:developer' as developer;

class MatchServiceMlb {
  final String mlbApiUrl = Urls.getHeadToHeadPredictionMlb;

  Map<String, String> getTeamLogoMap() {
    return {
      'Chicago Cubs': ImagePath.bostonRedSox,
      'Boston Red Sox': ImagePath.bostonRedSox,
      'Atlanta Braves': ImagePath.newYorkYankees,
      'New York Yankees': ImagePath.newYorkYankees,
      'Pittsburgh Pirates': ImagePath.newYorkYankees,
      'Chicago White Sox': ImagePath.bostonRedSox,
      'Philadelphia Phillies': ImagePath.newYorkYankees,
      'Los Angeles Angels': ImagePath.bostonRedSox,
      'Washington Nationals': ImagePath.newYorkYankees,
      'San Diego Padres': ImagePath.bostonRedSox,
      'Toronto Blue Jays': ImagePath.newYorkYankees,
      'San Francisco Giants': ImagePath.bostonRedSox,
      'New York Mets': ImagePath.newYorkYankees,
      'Cincinnati Reds': ImagePath.bostonRedSox,
      'Miami Marlins': ImagePath.newYorkYankees,
      'Kansas City Royals': ImagePath.bostonRedSox,
      'Cleveland Guardians': ImagePath.newYorkYankees,
      'Athletics': ImagePath.bostonRedSox,
      'Tampa Bay Rays': ImagePath.newYorkYankees,
      'Baltimore Orioles': ImagePath.bostonRedSox,
      'Texas Rangers': ImagePath.newYorkYankees,
      'Detroit Tigers': ImagePath.bostonRedSox,
      'Colorado Rockies': ImagePath.newYorkYankees,
      'Minnesota Twins': ImagePath.bostonRedSox,
      'Arizona Diamondbacks': ImagePath.newYorkYankees,
      'St. Louis Cardinals': ImagePath.bostonRedSox,
      'Seattle Mariners': ImagePath.newYorkYankees,
      'Houston Astros': ImagePath.bostonRedSox,
      'Los Angeles Dodgers': ImagePath.newYorkYankees,
      'Milwaukee Brewers': ImagePath.bostonRedSox,
    };
  }

  String _normalizeTeamName(String teamName) {
    return teamName
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join(' ');
  }

  String formatMatchTime(String datetimeUtc) {
    try {
      if (datetimeUtc.isEmpty) return 'Unknown';
      final inputFormat = DateFormat('dd.MM.yyyy HH:mm');
      final dateTime = inputFormat.parse(datetimeUtc);
      final outputFormat = DateFormat('dd MMM\nh:mm a');
      return outputFormat.format(dateTime);
    } catch (e) {
      developer.log('Error parsing date: $datetimeUtc, error: $e', name: 'MatchServiceMlb');
      return 'Unknown';
    }
  }

  String generatePredictionText(MatchModelMlb match) {
    if (match.prediction == null || match.prediction!.predictedScores == null) {
      return 'No prediction available';
    }
    final scores = match.prediction!.predictedScores!;
    final homeTeam = _normalizeTeamName(match.info.hometeam);
    final awayTeam = _normalizeTeamName(match.info.awayteam);
    final homeScore = scores[homeTeam] ?? scores[match.info.hometeam] ?? 0;
    final awayScore = scores[awayTeam] ?? scores[match.info.awayteam] ?? 0;
    return '$homeTeam is predicted to score $homeScore runs against $awayTeam, who is expected to score $awayScore runs.';
  }

  Future<List<Map<String, dynamic>>> fetchMLBGames() async {
    try {
      final response = await http.get(Uri.parse(mlbApiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData is! List) {
          developer.log('Unexpected API response: not a list', name: 'MatchServiceMlb');
          throw Exception('Invalid API response: expected a list');
        }
        final matches = jsonData.map((json) => MatchModelMlb.fromJson(json as Map<String, dynamic>)).toList();
        final filteredMatches = matches.where((match) => match.prediction != null).toList();

        if (filteredMatches.isEmpty) {
          developer.log('No valid matches after filtering', name: 'MatchServiceMlb');
        }

        return filteredMatches.map((match) {
          final logoMap = getTeamLogoMap();
          final normalizedHomeTeam = _normalizeTeamName(match.info.hometeam);
          final normalizedAwayTeam = _normalizeTeamName(match.info.awayteam);
          double team1Percentage = 0.0;
          double team2Percentage = 0.0;

          try {
            team1Percentage = double.tryParse(match.prediction!.homeWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
            team2Percentage = double.tryParse(match.prediction!.awayWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
          } catch (e) {
            developer.log('Error parsing percentages: ${match.prediction!.homeWinProbability}, ${match.prediction!.awayWinProbability}, error: $e', name: 'MatchServiceMlb');
          }

          return {
            'team1Name': normalizedHomeTeam,
            'team2Name': normalizedAwayTeam,
            'team1Image': logoMap[normalizedHomeTeam] ?? ImagePath.newYorkYankees,
            'team2Image': logoMap[normalizedAwayTeam] ?? ImagePath.bostonRedSox,
            'matchTime': formatMatchTime(match.info.datetimeUtc),
            'predictionText': generatePredictionText(match),
            'team1Percentage': team1Percentage,
            'team2Percentage': team2Percentage,
            'venue': match.info.venue, 
          };
        }).toList();
      } else {
        developer.log('API request failed with status: ${response.statusCode}', name: 'MatchServiceMlb');
        throw Exception('Failed to load MLB games: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      developer.log('Error fetching MLB games: $e', name: 'MatchServiceMlb', stackTrace: stackTrace);
      final mockData = [
        {
          'pred': {
            'home_win_probability': '52.01%',
            'away_win_probability': '47.99%',
            'confidence': '52.01%',
            'predicted_scores': {'Chicago Cubs': 4, 'Boston Red Sox': 4},
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Wrigley Field, Chicago, Illinois',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 18:20',
            'hometeam': 'Chicago Cubs',
            'awayteam': 'Boston Red Sox',
          },
        },
      ];
      final matches = mockData.map((json) => MatchModelMlb.fromJson(json)).toList();
      final filteredMatches = matches.where((match) => match.prediction != null).toList();

      return filteredMatches.map((match) {
        final logoMap = getTeamLogoMap();
        final normalizedHomeTeam = _normalizeTeamName(match.info.hometeam);
        final normalizedAwayTeam = _normalizeTeamName(match.info.awayteam);
        double team1Percentage = 0.0;
        double team2Percentage = 0.0;

        try {
          team1Percentage = double.tryParse(match.prediction!.homeWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
          team2Percentage = double.tryParse(match.prediction!.awayWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
        } catch (e) {
          developer.log('Error parsing mock data percentages: ${match.prediction!.homeWinProbability}, ${match.prediction!.awayWinProbability}, error: $e', name: 'MatchServiceMlb');
        }

        return {
          'team1Name': normalizedHomeTeam,
          'team2Name': normalizedAwayTeam,
          'team1Image': logoMap[normalizedHomeTeam] ?? ImagePath.newYorkYankees,
          'team2Image': logoMap[normalizedAwayTeam] ?? ImagePath.bostonRedSox,
          'matchTime': formatMatchTime(match.info.datetimeUtc),
          'predictionText': generatePredictionText(match),
          'team1Percentage': team1Percentage,
          'team2Percentage': team2Percentage,
          'venue': match.info.venue, 
        };
      }).toList();
    }
  }
}