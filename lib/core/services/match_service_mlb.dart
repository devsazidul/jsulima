import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jsulima/core/models/match_model_mlb.dart';
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'dart:developer' as developer;

class MatchServiceMlb {
  final String mlbApiUrl = Urls.getHeadToHeadPredictionMlb;
  static List<Map<String, dynamic>> _cachedMlbGames = []; // In-memory cache for MLB games

  Map<String, String> getTeamLogoMap() {
    return {
      'Chicago Cubs': ImagePath.chicagoCubs,
      'Boston Red Sox': ImagePath.bostonRedSox,
      'Atlanta Braves': ImagePath.atlantabraves,
      'New York Yankees': ImagePath.newYorkYankees,
      'Pittsburgh Pirates': ImagePath.pittsburghPirates,
      'Chicago White Sox': ImagePath.chicagoWhiteSox,
      'Philadelphia Phillies': ImagePath.philadelphiaPhillies,
      'Los Angeles Angels': ImagePath.losAngelesAngels,
      'Washington Nationals': ImagePath.newYorkYankees,
      'San Diego Padres': ImagePath.sanDiegoPadres,
      'Toronto Blue Jays': ImagePath.torontoBlueJays,
      'San Francisco Giants': ImagePath.sanFranciscoGiants,
      'New York Mets': ImagePath.newYorkMets,
      'Cincinnati Reds': ImagePath.cincinnatiReds,
      'Miami Marlins': ImagePath.miamiMarlins,
      'Kansas City Royals': ImagePath.kansasCityRoyals,
      'Cleveland Guardians': ImagePath.clevelandGuardians,
      'Athletics': ImagePath.athletics,
      'Tampa Bay Rays': ImagePath.tampaBayRays,
      'Baltimore Orioles': ImagePath.baltimoreOrioles,
      'Texas Rangers': ImagePath.texasRangers,
      'Detroit Tigers': ImagePath.detroitTigers,
      'Colorado Rockies': ImagePath.newYorkYankees,
      'Minnesota Twins': ImagePath.minnesotaTwins,
      'Arizona Diamondbacks': ImagePath.arizonaDiamondbacks,
      'St. Louis Cardinals': ImagePath.louisCardinals,
      'Seattle Mariners': ImagePath.seattleMariners,
      'Houston Astros': ImagePath.houstonAstros,
      'Los Angeles Dodgers': ImagePath.losAngelesDodgers,
      'Milwaukee Brewers': ImagePath.milwaukeeBrewers,
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
      // Parse as UTC
      final dateTime = inputFormat.parse(datetimeUtc, true);
      // Adjust to EDT (UTC-04:00)
      final edtDateTime = dateTime.subtract(Duration(hours: 4));
      // Output format with month as number and '/' separator (e.g., "31/07\n1:05 PM")
      final outputFormat = DateFormat('dd/MM\nh:mm a');
      return outputFormat.format(edtDateTime);
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
    if (_cachedMlbGames.isNotEmpty) {
      if (kDebugMode) {
        print("Loaded ${_cachedMlbGames.length} MLB games from cache");
      }
      return _cachedMlbGames;
    }

    try {
      if (kDebugMode) {
        print("Fetching MLB games from API");
      }
      final response = await http.post(Uri.parse(mlbApiUrl));
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

        final games = filteredMatches.map((match) {
          final logoMap = getTeamLogoMap();
          final normalizedHomeTeam = _normalizeTeamName(match.info.hometeam);
          final normalizedAwayTeam = _normalizeTeamName(match.info.awayteam);
          double team1Percentage = 0.0;
          double team2Percentage = 0.0;
          double confidence = 0.0;

          try {
            team1Percentage = double.tryParse(match.prediction!.homeWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
            team2Percentage = double.tryParse(match.prediction!.awayWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
            confidence = double.tryParse(match.prediction!.confidence!.replaceAll('%', '').trim()) ?? 0.0;
          } catch (e) {
            developer.log('Error parsing percentages: ${match.prediction!.homeWinProbability}, ${match.prediction!.awayWinProbability}, ${match.prediction!.confidence}, error: $e', name: 'MatchServiceMlb');
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
            'confidence': confidence,
            'venue': match.info.venue,
          };
        }).toList();

        _cachedMlbGames = List.from(games);
        if (kDebugMode) {
          print("Cached ${games.length} MLB games");
        }
        return games;
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

      final games = filteredMatches.map((match) {
        final logoMap = getTeamLogoMap();
        final normalizedHomeTeam = _normalizeTeamName(match.info.hometeam);
        final normalizedAwayTeam = _normalizeTeamName(match.info.awayteam);
        double team1Percentage = 0.0;
        double team2Percentage = 0.0;
        double confidence = 0.0;

        try {
          team1Percentage = double.tryParse(match.prediction!.homeWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
          team2Percentage = double.tryParse(match.prediction!.awayWinProbability!.replaceAll('%', '').trim()) ?? 0.0;
          confidence = double.tryParse(match.prediction!.confidence!.replaceAll('%', '').trim()) ?? 0.0;
        } catch (e) {
          developer.log('Error parsing mock data percentages: ${match.prediction!.homeWinProbability}, ${match.prediction!.awayWinProbability}, ${match.prediction!.confidence}, error: $e', name: 'MatchServiceMlb');
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
          'confidence': confidence,
          'venue': match.info.venue,
        };
      }).toList();

      _cachedMlbGames = List.from(games);
      if (kDebugMode) {
        print("Cached ${games.length} MLB mock games");
      }
      return games;
    }
  }
}