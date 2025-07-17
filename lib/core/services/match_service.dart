import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jsulima/core/models/match_model.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';

class MatchService {
  final String mlbApiUrl = 'https://game-api-ai.onrender.com/predict/mlb/head-to-head-win-prediction';
  final String nflApiUrl = 'https://game-api-ai.onrender.com/predict/nfl/head-to-head-win-prediction';

  Map<String, String> getTeamLogoMap() {
    return {
      // MLB Teams
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
      // NFL Teams
      'Detroit Lions': ImagePath.nflTeam1, 
      'Los Angeles Chargers': ImagePath.nflTeam2,
      'Baltimore Ravens': ImagePath.nflTeam1,
      'Indianapolis Colts': ImagePath.nflTeam2,
      'Philadelphia Eagles': ImagePath.nflTeam1,
      'Cincinnati Bengals': ImagePath.nflTeam2,
      'Atlanta Falcons': ImagePath.nflTeam1,
      'Carolina Panthers': ImagePath.nflTeam2,
      'Cleveland Browns': ImagePath.nflTeam1,
      'New England Patriots': ImagePath.nflTeam2,
      'Washington Commanders': ImagePath.nflTeam1,
      'Minnesota Vikings': ImagePath.nflTeam2,
      'Houston Texans': ImagePath.nflTeam1,
      'Dallas Cowboys': ImagePath.nflTeam2,
      'Jacksonville Jaguars': ImagePath.nflTeam1,
      'Pittsburgh Steelers': ImagePath.nflTeam2,
      'Tampa Bay Buccaneers': ImagePath.nflTeam1,
      'Tennessee Titans': ImagePath.nflTeam2,
      'New York Jets': ImagePath.nflTeam1,
      'New Orleans Saints': ImagePath.nflTeam2,
      'Green Bay Packers': ImagePath.nflTeam1,
      'Buffalo Bills': ImagePath.nflTeam2,
      'Kansas City Chiefs': ImagePath.nflTeam1,
      'Denver Broncos': ImagePath.nflTeam2,
      'Seattle Seahawks': ImagePath.nflTeam1,
      'San Francisco 49ers': ImagePath.nflTeam2,
      'New York Giants': ImagePath.nflTeam1,
      'Las Vegas Raiders': ImagePath.nflTeam2,
      'Arizona Cardinals': ImagePath.nflTeam1,
    };
  }

  String formatMatchTime(String datetimeUtc) {
    try {
      final inputFormat = DateFormat('dd.MM.yyyy HH:mm');
      final dateTime = inputFormat.parse(datetimeUtc);
      final outputFormat = DateFormat(' dd MMM\nh:mm a');
      return outputFormat.format(dateTime);
    } catch (e) {
      return ' Unknown';
    }
  }

  String generatePredictionText(MatchModel match, String sport) {
    if (match.prediction == null || match.prediction!.predictedScores == null) {
      return 'No prediction available';
    }
    final scores = match.prediction!.predictedScores!;
    final homeTeam = match.info.hometeam;
    final awayTeam = match.info.awayteam;
    final homeScore = scores[homeTeam] ?? 0;
    final awayScore = scores[awayTeam] ?? 0;
    final scoreUnit = sport == 'MLB' ? 'runs' : 'points';
    return '$homeTeam is predicted to score $homeScore $scoreUnit against $awayTeam, who is expected to score $awayScore $scoreUnit.';
  }

  Future<List<Map<String, dynamic>>> fetchMLBGames() async {
    try {
      final response = await http.get(Uri.parse(mlbApiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final matches = jsonList.map((json) => MatchModel.fromJson(json)).toList();

        return matches
            .where((match) => match.prediction != null)
            .map((match) {
          final logoMap = getTeamLogoMap();
          return {
            'team1Name': match.info.hometeam,
            'team2Name': match.info.awayteam,
            'team1Image': logoMap[match.info.hometeam] ?? ImagePath.newYorkYankees,
            'team2Image': logoMap[match.info.awayteam] ?? ImagePath.bostonRedSox,
            'matchTime': formatMatchTime(match.info.datetimeUtc),
            'predictionText': generatePredictionText(match, 'MLB'),
            'team1Percentage': double.parse(match.prediction!.homeWinProbability!.replaceAll('%', '')),
            'team2Percentage': double.parse(match.prediction!.awayWinProbability!.replaceAll('%', '')),
          };
        }).toList();
      } else {
        throw Exception('Failed to load MLB games: ${response.statusCode}');
      }
    } catch (e) {
      final mockData = [
        {
          'pred': {
            'home_win_probability': '52.01%',
            'away_win_probability': '47.99%',
            'confidence': '52.01%',
            'predicted_scores': {'CHICAGO CUBS': 4, 'BOSTON RED SOX': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Wrigley Field, Chicago, Illinois',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 18:20',
            'hometeam': 'Chicago Cubs',
            'awayteam': 'Boston Red Sox'
          }
        },
      ];
      final matches = mockData.map((json) => MatchModel.fromJson(json)).toList();
      return matches
          .where((match) => match.prediction != null)
          .map((match) {
        final logoMap = getTeamLogoMap();
        return {
          'team1Name': match.info.hometeam,
          'team2Name': match.info.awayteam,
          'team1Image': logoMap[match.info.hometeam] ?? ImagePath.newYorkYankees,
          'team2Image': logoMap[match.info.awayteam] ?? ImagePath.bostonRedSox,
          'matchTime': formatMatchTime(match.info.datetimeUtc),
          'predictionText': generatePredictionText(match, 'MLB'),
          'team1Percentage': double.parse(match.prediction!.homeWinProbability!.replaceAll('%', '')),
          'team2Percentage': double.parse(match.prediction!.awayWinProbability!.replaceAll('%', '')),
        };
      }).toList();
    }
  }

  Future<List<Map<String, dynamic>>> fetchNFLGames() async {
    try {
      final response = await http.get(Uri.parse(nflApiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final matches = jsonList.map((json) => MatchModel.fromJson(json)).toList();

        return matches
            .where((match) => match.prediction != null)
            .map((match) {
          final logoMap = getTeamLogoMap();
          return {
            'team1Name': match.info.hometeam,
            'team2Name': match.info.awayteam,
            'team1Image': logoMap[match.info.hometeam] ?? "assets/images/team1.png",
            'team2Image': logoMap[match.info.awayteam] ?? "assets/images/team2.png",
            'matchTime': formatMatchTime(match.info.datetimeUtc),
            'predictionText': generatePredictionText(match, 'NFL'),
            'team1Percentage': double.parse(match.prediction!.homeWinProbability!),
            'team2Percentage': double.parse(match.prediction!.awayWinProbability!),
          };
        }).toList();
      } else {
        throw Exception('Failed to load NFL games: ${response.statusCode}');
      }
    } catch (e) {
      final mockData = [
        {
          "home_team": "Detroit Lions",
          "away_team": "Los Angeles Chargers",
          "home_win_probability": 84,
          "away_win_probability": 16,
          "confidence": 68,
          "predicted_scores": {
            "Detroit Lions": 13,
            "Los Angeles Chargers": 10
          },
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
              "@id": "1695"
            },
            "awayteam": {
              "@name": "Los Angeles Chargers",
              "@q1": "",
              "@q2": "",
              "@q3": "",
              "@q4": "",
              "@ot": "",
              "@totalscore": "",
              "@id": "1702"
            }
          }
        },
      ];
      final matches = mockData.map((json) => MatchModel.fromJson(json)).toList();
      return matches
          .where((match) => match.prediction != null)
          .map((match) {
        final logoMap = getTeamLogoMap();
        return {
          'team1Name': match.info.hometeam,
          'team2Name': match.info.awayteam,
          'team1Image': logoMap[match.info.hometeam] ?? ImagePath.nflTeam1,
          'team2Image': logoMap[match.info.awayteam] ?? ImagePath.nflTeam2,
          'matchTime': formatMatchTime(match.info.datetimeUtc),
          'predictionText': generatePredictionText(match, 'NFL'),
          'team1Percentage': double.parse(match.prediction!.homeWinProbability!),
          'team2Percentage': double.parse(match.prediction!.awayWinProbability!),
        };
      }).toList();
    }
  }
}