class LineupPlayerModel {
  final String teamName;
  final String positionGroup;
  final String playerName;
  final int playerNumber;
  final String playerPosition;
  final String bats;
  final String? battingSpot;
  final String status;
  final double starterProbability;
  final String? throws;
  final int? positionNumber;

  LineupPlayerModel({
    required this.teamName,
    required this.positionGroup,
    required this.playerName,
    required this.playerNumber,
    required this.playerPosition,
    required this.bats,
    this.battingSpot,
    required this.status,
    required this.starterProbability,
    this.throws,
    this.positionNumber,
  });

  factory LineupPlayerModel.fromJson(Map<String, dynamic> json) {
    return LineupPlayerModel(
      teamName: json['team_name'],
      positionGroup: json['position_group'],
      playerName: json['player_name'],
      playerNumber: json['player_number'],
      playerPosition: json['player_position'],
      bats: json['bats'],
      battingSpot: json['batting_spot'],
      status: json['status'],
      starterProbability: json['starter_probability'].toDouble(),
      throws: json['throws'],
      positionNumber: json['position_number'],
    );
  }
}

class LineupResponse {
  final List<LineupPlayerModel> lineup;
  final String? imageBase64;

  LineupResponse({required this.lineup, this.imageBase64});

  factory LineupResponse.fromJson(Map<String, dynamic> json) {
    var lineupList = json['lineup'] as List;
    List<LineupPlayerModel> players =
        lineupList.map((i) => LineupPlayerModel.fromJson(i)).toList();
    return LineupResponse(lineup: players, imageBase64: json['image_base64']);
  }
}
