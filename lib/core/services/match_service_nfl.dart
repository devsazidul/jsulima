import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jsulima/core/models/match_model_nfl.dart';
import 'package:jsulima/core/services/end_points.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'dart:developer' as developer;

class MatchServiceNfl {
  final String nflApiUrl = Urls.getHeadToHeadPredictionNfl;
  static List<Map<String, dynamic>> _cachedNflGames = [];

  Map<String, String> getTeamLogoMap() {
    return {
      'Detroit Lions': ImagePath.detroitLions,
      'Miami Dolphins': ImagePath.miamiDolphins,
      'Los Angeles Chargers': ImagePath.losAngelesChargers,
      'Los Angeles Rams': ImagePath.losAngelesRams,
      'Baltimore Ravens': ImagePath.baltimoreRavens,
      'Indianapolis Colts': ImagePath.indianapolisColts,
      'Philadelphia Eagles': ImagePath.philadelphiaEagles,
      'Cincinnati Bengals': ImagePath.cincinnatiBengals,
      'Atlanta Falcons': ImagePath.atlantaFalcons,
      'Carolina Panthers': ImagePath.carolinaPanthers,
      'Cleveland Browns': ImagePath.clevelandBrowns,
      'New England Patriots': ImagePath.newEnglandPatriots,
      'Washington Commanders': ImagePath.washingtonCommanders,
      'Minnesota Vikings': ImagePath.minnesotaVikings,
      'Houston Texans': ImagePath.houstonTexans,
      'Dallas Cowboys': ImagePath.dallasCowboys,
      'Jacksonville Jaguars': ImagePath.jacksonvilleJaguars,
      'Pittsburgh Steelers': ImagePath.pittsburghPirates,
      'Tampa Bay Buccaneers': ImagePath.tampaBayBuccaneers,
      'Tennessee Titans': ImagePath.tennesseeTitans,
      'New York Jets': ImagePath.newYorkJets,
      'New Orleans Saints': ImagePath.newOrleansSaints,
      'Green Bay Packers': ImagePath.greenBayPackers,
      'Buffalo Bills': ImagePath.buffaloBills,
      'Kansas City Chiefs': ImagePath.kansasCityChiefs,
      'Denver Broncos': ImagePath.denverBroncos,
      'Seattle Seahawks': ImagePath.seattleSeahawks,
      'San Francisco 49ers': ImagePath.sanFrancisco49ers,
      'New York Giants': ImagePath.newYorkGiants,
      'Las Vegas Raiders': ImagePath.lasVegasRaiders,
      'Arizona Cardinals': ImagePath.arizonaCardinals,
    };
  }

  String formatMatchTime(String datetimeUtc) {
    try {
      if (datetimeUtc.isEmpty) return 'Unknown';
      final inputFormat = DateFormat('dd.MM.yyyy HH:mm');
      // Parse as UTC
      final dateTime = inputFormat.parse(datetimeUtc, true);
      // Adjust to EDT (UTC-04:00)
      final edtDateTime = dateTime.subtract(Duration(hours: 4));
      // Output format with month as number and '/' separator (e.g., "31/07\n8:00 PM")
      final outputFormat = DateFormat('MM/dd\nh:mm a');
      return outputFormat.format(edtDateTime);
    } catch (e) {
      developer.log(
        'Error parsing date: $datetimeUtc, error: $e',
        name: 'MatchServiceNfl',
      );
      return 'Unknown';
    }
  }

  String generatePredictionText(MatchModelNfl match) {
    if (match.prediction == null || match.prediction!.predictedScores == null) {
      return 'No prediction available';
    }
    final scores = match.prediction!.predictedScores!;
    final homeTeam = match.info.hometeam;
    final awayTeam = match.info.awayteam;
    final homeScore = scores[homeTeam] ?? 0;
    final awayScore = scores[awayTeam] ?? 0;
    return '$homeTeam is predicted to score $homeScore points against $awayTeam, who is expected to score $awayScore points.';
  }

  Future<List<Map<String, dynamic>>> fetchNFLGames() async {
    if (_cachedNflGames.isNotEmpty) {
      if (kDebugMode) {
        print("Loaded ${_cachedNflGames.length} NFL games from cache");
      }
      return _cachedNflGames;
    }

    try {
      if (kDebugMode) {
        print("Fetching NFL games from API");
      }
      final response = await http.post(Uri.parse(nflApiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final matches =
            jsonList.map((json) => MatchModelNfl.fromJson(json)).toList();
        final games =
            matches.where((match) => match.prediction != null).map((match) {
              final logoMap = getTeamLogoMap();
              double team1Percentage = 0.0;
              double team2Percentage = 0.0;
              double confidence = 0.0;

              try {
                team1Percentage = double.parse(
                  match.prediction!.homeWinProbability!,
                );
                team2Percentage = double.parse(
                  match.prediction!.awayWinProbability!,
                );
                confidence = double.parse(match.prediction!.confidence!);
              } catch (e) {
                developer.log(
                  'Error parsing percentages: ${match.prediction!.homeWinProbability}, ${match.prediction!.awayWinProbability}, ${match.prediction!.confidence}, error: $e',
                  name: 'MatchServiceNfl',
                );
              }

              return {
                'team1Name': match.info.hometeam,
                'team2Name': match.info.awayteam,
                'team1Image':
                    logoMap[match.info.hometeam] ?? ImagePath.nflTeam1,
                'team2Image':
                    logoMap[match.info.awayteam] ?? ImagePath.nflTeam2,
                'matchTime': formatMatchTime(match.info.datetimeUtc),
                'predictionText': generatePredictionText(match),
                'team1Percentage': team1Percentage,
                'team2Percentage': team2Percentage,
                'confidence': confidence,
                'venue': match.info.venue,
              };
            }).toList();

        _cachedNflGames = List.from(games);
        if (kDebugMode) {
          print("Cached ${games.length} NFL games");
        }
        return games;
      } else {
        throw Exception('Failed to load NFL games: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Error fetching NFL games: $e', name: 'MatchServiceNfl');
      final mockData = [
        {
          "home_team": "Detroit Lions",
          "away_team": "Los Angeles Chargers",
          "home_win_probability": 84,
          "away_win_probability": 16,
          "confidence": 68,
          "predicted_scores": {"Detroit Lions": 13, "Los Angeles Chargers": 10},
          "info": {
            "@time": "7:00 PM",
            "@contestID": "204729",
            "@formatted_date": "31.07.2025",
            "@status": "Not Started",
            "@venue": "Tom Benson Hall of Fame Stadium, Canton, USA",
            "@venue_id": "2647",
            "@attendance": "",
            "@datetime_utc": "01.08.2025 00:00",
            "hometeam": {
              "@name": "Detroit Lions",
              "@q1": "",
              "@q2": "",
              "@q3": "",
              "@q4": "",
              "@ot": "",
              "@totalscore": "",
              "@id": "1695",
            },
            "awayteam": {
              "@name": "Los Angeles Chargers",
              "@q1": "",
              "@q2": "",
              "@q3": "",
              "@q4": "",
              "@ot": "",
              "@totalscore": "",
              "@id": "1702",
            },
          },
        },
      ];
      final matches =
          mockData.map((json) => MatchModelNfl.fromJson(json)).toList();
      final games =
          matches.where((match) => match.prediction != null).map((match) {
            final logoMap = getTeamLogoMap();
            double team1Percentage = 0.0;
            double team2Percentage = 0.0;
            double confidence = 0.0;

            try {
              team1Percentage = double.parse(
                match.prediction!.homeWinProbability!,
              );
              team2Percentage = double.parse(
                match.prediction!.awayWinProbability!,
              );
              confidence = double.parse(match.prediction!.confidence!);
            } catch (e) {
              developer.log(
                'Error parsing mock data percentages: ${match.prediction!.homeWinProbability}, ${match.prediction!.awayWinProbability}, ${match.prediction!.confidence}, error: $e',
                name: 'MatchServiceNfl',
              );
            }

            return {
              'team1Name': match.info.hometeam,
              'team2Name': match.info.awayteam,
              'team1Image': logoMap[match.info.hometeam] ?? ImagePath.nflTeam1,
              'team2Image': logoMap[match.info.awayteam] ?? ImagePath.nflTeam2,
              'matchTime': formatMatchTime(match.info.datetimeUtc),
              'predictionText': generatePredictionText(match),
              'team1Percentage': team1Percentage,
              'team2Percentage': team2Percentage,
              'confidence': confidence,
              'venue': match.info.venue,
            };
          }).toList();

      _cachedNflGames = List.from(games);
      if (kDebugMode) {
        print("Cached ${games.length} NFL mock games");
      }
      return games;
    }
  }
}
