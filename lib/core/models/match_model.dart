class MatchModel {
  final Prediction? prediction;
  final MatchInfo info;

  MatchModel({required this.prediction, required this.info});

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      prediction:
          json['pred'] != null && json['pred']['error'] == null
              ? Prediction.fromJson(json['pred'])
              : null,
      info: MatchInfo.fromJson(json['info']),
    );
  }
}

class Prediction {
  final String? homeWinProbability;
  final String? awayWinProbability;
  final String? confidence;
  final Map<String, int>? predictedScores;

  Prediction({
    this.homeWinProbability,
    this.awayWinProbability,
    this.confidence,
    this.predictedScores,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      homeWinProbability: json['home_win_probability']?.toString(),
      awayWinProbability: json['away_win_probability']?.toString(),
      confidence: json['confidence']?.toString(),
      predictedScores:
          json['predicted_scores'] != null
              ? Map<String, int>.from(
                json['predicted_scores'].map(
                  (key, value) => MapEntry(
                    key,
                    value is int ? value : int.parse(value.toString()),
                  ),
                ),
              )
              : null,
    );
  }
}

class MatchInfo {
  final String date;
  final String timezone;
  final String seasonType;
  final String venue;
  final String formattedDate;
  final String datetimeUtc;
  final String hometeam;
  final String awayteam;

  MatchInfo({
    required this.date,
    required this.timezone,
    required this.seasonType,
    required this.venue,
    required this.formattedDate,
    required this.datetimeUtc,
    required this.hometeam,
    required this.awayteam,
  });

  factory MatchInfo.fromJson(Map<String, dynamic> json) {
    return MatchInfo(
      date: json['date'] ?? '',
      timezone: json['timezone'] ?? '',
      seasonType: json['seasonType'] ?? '',
      venue: json['venue'] ?? '',
      formattedDate: json['formatted_date'] ?? '',
      datetimeUtc: json['datetime_utc'] ?? '',
      hometeam: json['hometeam'] ?? '',
      awayteam: json['awayteam'] ?? '',
    );
  }
}
