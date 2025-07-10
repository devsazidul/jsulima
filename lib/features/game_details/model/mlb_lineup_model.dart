class MlbLineupResponse {
  final List<MlbPlayer> lineup;
  final String imageBase64;

  MlbLineupResponse({required this.lineup, required this.imageBase64});

  factory MlbLineupResponse.fromJson(Map<String, dynamic> json) {
    return MlbLineupResponse(
      lineup:
          (json['lineup'] as List<dynamic>?)
              ?.map((e) => MlbPlayer.fromJson(e))
              .toList() ??
          [],
      imageBase64: json['image_base64']?.toString() ?? '',
    );
  }
}

class MlbPlayer {
  final String teamName;
  final String positionGroup;
  final String playerName;
  final int playerNumber;
  final String playerPosition;
  final String bats;
  final String battingSpot;
  final String status;
  final double starterProbability;
  final String? throwsHand;
  final int? positionNumber;

  MlbPlayer({
    required this.teamName,
    required this.positionGroup,
    required this.playerName,
    required this.playerNumber,
    required this.playerPosition,
    required this.bats,
    required this.battingSpot,
    required this.status,
    required this.starterProbability,
    this.throwsHand,
    this.positionNumber,
  });

  factory MlbPlayer.fromJson(Map<String, dynamic> json) {
    return MlbPlayer(
      teamName: json['team_name']?.toString() ?? '',
      positionGroup: json['position_group']?.toString() ?? '',
      playerName: json['player_name']?.toString() ?? '',
      playerNumber:
          json['player_number'] is int
              ? json['player_number']
              : (json['player_number'] is double
                  ? (json['player_number'] as double).toInt()
                  : int.tryParse(json['player_number']?.toString() ?? '0') ??
                      0),
      playerPosition: json['player_position']?.toString() ?? '',
      bats: json['bats']?.toString() ?? '',
      battingSpot: json['batting_spot']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      starterProbability:
          json['starter_probability'] is double
              ? json['starter_probability']
              : json['starter_probability'] is int
              ? (json['starter_probability'] as int).toDouble()
              : double.tryParse(
                    json['starter_probability']?.toString() ?? '0.0',
                  ) ??
                  0.0,
      throwsHand: json['throws']?.toString(),
      positionNumber:
          json['position_number'] == null
              ? null
              : (json['position_number'] is int
                  ? json['position_number']
                  : (json['position_number'] is double
                      ? (json['position_number'] as double).toInt()
                      : int.tryParse(
                        json['position_number']?.toString() ?? '0',
                      ))),
    );
  }
}
