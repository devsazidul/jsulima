import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jsulima/core/models/match_model.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';

class MatchService {
  final String apiUrl = 'https://game-api-ai.onrender.com/predict/mlb/head-to-head-win-prediction';

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

  String generatePredictionText(MatchModel match) {
    if (match.prediction == null || match.prediction!.predictedScores == null) {
      return 'No prediction available';
    }
    final scores = match.prediction!.predictedScores!;
    final homeTeam = match.info.hometeam;
    final awayTeam = match.info.awayteam;
    final homeScore = scores[homeTeam] ?? 0;
    final awayScore = scores[awayTeam] ?? 0;
    return '$homeTeam is predicted to score $homeScore runs against $awayTeam, who is expected to score $awayScore runs.';
  }

  Future<List<Map<String, dynamic>>> fetchMLBGames() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
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
            'predictionText': generatePredictionText(match),
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
        {
          'pred': {
            'home_win_probability': '44.19%',
            'away_win_probability': '55.81%',
            'confidence': '55.81%',
            'predicted_scores': {'ATLANTA BRAVES': 3, 'NEW YORK YANKEES': 3}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Truist Park, Atlanta, Georgia',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 23:15',
            'hometeam': 'Atlanta Braves',
            'awayteam': 'New York Yankees'
          }
        },
        {
          'pred': {
            'home_win_probability': '52.32%',
            'away_win_probability': '47.68%',
            'confidence': '52.32%',
            'predicted_scores': {'PITTSBURGH PIRATES': 3, 'CHICAGO WHITE SOX': 3}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'PNC Park, Pittsburgh, Pennsylvania',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 22:40',
            'hometeam': 'Pittsburgh Pirates',
            'awayteam': 'Chicago White Sox'
          }
        },
        {
          'pred': {
            'home_win_probability': '57.50%',
            'away_win_probability': '42.50%',
            'confidence': '57.50%',
            'predicted_scores': {'PHILADELPHIA PHILLIES': 4, 'LOS ANGELES ANGELS': 3}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Citizens Bank Park, Philadelphia, Pennsylvania',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 22:45',
            'hometeam': 'Philadelphia Phillies',
            'awayteam': 'Los Angeles Angels'
          }
        },
        {
          'pred': {
            'home_win_probability': '43.46%',
            'away_win_probability': '56.54%',
            'confidence': '56.54%',
            'predicted_scores': {'WASHINGTON NATIONALS': 4, 'SAN DIEGO PADRES': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Nationals Park, Washington, District of Columbia',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 22:45',
            'hometeam': 'Washington Nationals',
            'awayteam': 'San Diego Padres'
          }
        },
        {
          'pred': {
            'home_win_probability': '40.84%',
            'away_win_probability': '59.16%',
            'confidence': '59.16%',
            'predicted_scores': {'TORONTO BLUE JAYS': 3, 'SAN FRANCISCO GIANTS': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Rogers Centre, Toronto, Ontario',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 23:07',
            'hometeam': 'Toronto Blue Jays',
            'awayteam': 'San Francisco Giants'
          }
        },
        {
          'pred': {
            'home_win_probability': '52.84%',
            'away_win_probability': '47.16%',
            'confidence': '52.84%',
            'predicted_scores': {'NEW YORK METS': 3, 'CINCINNATI REDS': 3}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Citi Field, Queens, New York',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 23:10',
            'hometeam': 'New York Mets',
            'awayteam': 'Cincinnati Reds'
          }
        },
        {
          'pred': {
            'home_win_probability': '38.35%',
            'away_win_probability': '61.65%',
            'confidence': '61.65%',
            'predicted_scores': {'MIAMI MARLINS': 4, 'KANSAS CITY ROYALS': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'loanDepot park, Miami, Florida',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 23:10',
            'hometeam': 'Miami Marlins',
            'awayteam': 'Kansas City Royals'
          }
        },
        {
          'pred': {
            'home_win_probability': '51.26%',
            'away_win_probability': '48.74%',
            'confidence': '51.26%',
            'predicted_scores': {'CLEVELAND GUARDIANS': 4, 'ATHLETICS': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Progressive Field, Cleveland, Ohio',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 23:10',
            'hometeam': 'Cleveland Guardians',
            'awayteam': 'Athletics'
          }
        },
        {
          'pred': {
            'home_win_probability': '64.79%',
            'away_win_probability': '35.21%',
            'confidence': '64.79%',
            'predicted_scores': {'TAMPA BAY RAYS': 5, 'BALTIMORE ORIOLES': 3}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'George M. Steinbrenner Field, Tampa, Florida',
            'formatted_date': '18.07.2025',
            'datetime_utc': '18.07.2025 23:35',
            'hometeam': 'Tampa Bay Rays',
            'awayteam': 'Baltimore Orioles'
          }
        },
        {
          'pred': {
            'home_win_probability': '44.48%',
            'away_win_probability': '55.52%',
            'confidence': '55.52%',
            'predicted_scores': {'TEXAS RANGERS': 3, 'DETROIT TIGERS': 3}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Globe Life Field, Arlington, Texas',
            'formatted_date': '18.07.2025',
            'datetime_utc': '19.07.2025 00:05',
            'hometeam': 'Texas Rangers',
            'awayteam': 'Detroit Tigers'
          }
        },
        {
          'pred': {
            'home_win_probability': '35.99%',
            'away_win_probability': '64.01%',
            'confidence': '64.01%',
            'predicted_scores': {'COLORADO ROCKIES': 4, 'MINNESOTA TWINS': 5}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Coors Field, Denver, Colorado',
            'formatted_date': '18.07.2025',
            'datetime_utc': '19.07.2025 00:40',
            'hometeam': 'Colorado Rockies',
            'awayteam': 'Minnesota Twins'
          }
        },
        {
          'pred': {
            'home_win_probability': '45.81%',
            'away_win_probability': '54.19%',
            'confidence': '54.19%',
            'predicted_scores': {'ARIZONA DIAMONDBACKS': 4, 'ST. LOUIS CARDINALS': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Chase Field, Phoenix, Arizona',
            'formatted_date': '18.07.2025',
            'datetime_utc': '19.07.2025 01:40',
            'hometeam': 'Arizona Diamondbacks',
            'awayteam': 'St. Louis Cardinals'
          }
        },
        {
          'pred': {
            'home_win_probability': '44.17%',
            'away_win_probability': '55.83%',
            'confidence': '55.83%',
            'predicted_scores': {'SEATTLE MARINERS': 4, 'HOUSTON ASTROS': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'T-Mobile Park, Seattle, Washington',
            'formatted_date': '18.07.2025',
            'datetime_utc': '19.07.2025 02:10',
            'hometeam': 'Seattle Mariners',
            'awayteam': 'Houston Astros'
          }
        },
        {
          'pred': {
            'home_win_probability': '51.00%',
            'away_win_probability': '49.00%',
            'confidence': '51.00%',
            'predicted_scores': {'LOS ANGELES DODGERS': 4, 'MILWAUKEE BREWERS': 4}
          },
          'info': {
            'date': 'Friday, July 18',
            'timezone': 'EST',
            'seasonType': 'Regular Season',
            'venue': 'Dodger Stadium, Los Angeles, California',
            'formatted_date': '18.07.2025',
            'datetime_utc': '19.07.2025 02:10',
            'hometeam': 'Los Angeles Dodgers',
            'awayteam': 'Milwaukee Brewers'
          }
        }
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
          'predictionText': generatePredictionText(match),
          'team1Percentage': double.parse(match.prediction!.homeWinProbability!.replaceAll('%', '')),
          'team2Percentage': double.parse(match.prediction!.awayWinProbability!.replaceAll('%', '')),
        };
      }).toList();
    }
  }
}