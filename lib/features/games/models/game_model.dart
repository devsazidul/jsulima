class GameModel {
  String team1Name;
  String team2Name;
  String team1Image;
  String team2Image;
  String matchTime;
  String predictionText;
  double team1Percentage;
  double team2Percentage;

  GameModel({
    required this.team1Name,
    required this.team2Name,
    required this.team1Image,
    required this.team2Image,
    required this.matchTime,
    required this.predictionText,
    required this.team1Percentage,
    required this.team2Percentage,
  });

  // From JSON to Dart object
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      team1Name: json['team1Name'],
      team2Name: json['team2Name'],
      team1Image: json['team1Image'],
      team2Image: json['team2Image'],
      matchTime: json['matchTime'],
      predictionText: json['predictionText'],
      team1Percentage: json['team1Percentage'].toDouble(),
      team2Percentage: json['team2Percentage'].toDouble(),
    );
  }

  // From Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'team1Name': team1Name,
      'team2Name': team2Name,
      'team1Image': team1Image,
      'team2Image': team2Image,
      'matchTime': matchTime,
      'predictionText': predictionText,
      'team1Percentage': team1Percentage,
      'team2Percentage': team2Percentage,
    };
  }
}
