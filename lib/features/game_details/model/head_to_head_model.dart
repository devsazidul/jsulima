class HeadToHeadMatch {
  final String date;
  final String homeTeam;
  final String awayTeam;
  final int homeScore;
  final int awayScore;

  HeadToHeadMatch({
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
  });

  factory HeadToHeadMatch.fromJson(Map<String, dynamic> json) {
    return HeadToHeadMatch(
      date: json['date'] ?? '',
      homeTeam: json['home_team'] ?? '',
      awayTeam: json['away_team'] ?? '',
      homeScore: json['home_score'] ?? 0,
      awayScore: json['away_score'] ?? 0,
    );
  }
}

class HeadToHeadModel {
  final int wins;
  final int losses;
  final int draws;
  final List<HeadToHeadMatch> matches;

  HeadToHeadModel({
    required this.wins,
    required this.losses,
    required this.draws,
    required this.matches,
  });

  factory HeadToHeadModel.fromJson(Map<String, dynamic> json) {
    var matchesList = json['matches'] as List?;
    List<HeadToHeadMatch> matches =
        matchesList != null
            ? matchesList.map((e) => HeadToHeadMatch.fromJson(e)).toList()
            : [];
    return HeadToHeadModel(
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      matches: matches,
    );
  }
}
