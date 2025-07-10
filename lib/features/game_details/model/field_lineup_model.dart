import 'package:flutter/foundation.dart';

class FieldLineupResponse {
  final List<FieldPlayer> homePlayers;
  final List<FieldPlayer> awayPlayers;
  final String lineupImage;

  FieldLineupResponse({
    required this.homePlayers,
    required this.awayPlayers,
    required this.lineupImage,
  });

  factory FieldLineupResponse.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('FieldLineupResponse.fromJson: Starting parsing');
      print('FieldLineupResponse.fromJson: JSON keys: ${json.keys.toList()}');
    }

    try {
      final homePlayersList = json['home_players'] as List<dynamic>? ?? [];
      final awayPlayersList = json['away_players'] as List<dynamic>? ?? [];

      if (kDebugMode) {
        print(
          'FieldLineupResponse.fromJson: home_players list length: ${homePlayersList.length}',
        );
        print(
          'FieldLineupResponse.fromJson: away_players list length: ${awayPlayersList.length}',
        );
      }

      final homePlayers =
          homePlayersList
              .map((player) => FieldPlayer.fromJson(player))
              .toList();

      final awayPlayers =
          awayPlayersList
              .map((player) => FieldPlayer.fromJson(player))
              .toList();

      final lineupImage = json['lineup_image']?.toString() ?? '';

      if (kDebugMode) {
        print('FieldLineupResponse.fromJson: Successfully parsed');
        print(
          'FieldLineupResponse.fromJson: homePlayers count: ${homePlayers.length}',
        );
        print(
          'FieldLineupResponse.fromJson: awayPlayers count: ${awayPlayers.length}',
        );
        print(
          'FieldLineupResponse.fromJson: lineupImage length: ${lineupImage.length}',
        );
      }

      return FieldLineupResponse(
        homePlayers: homePlayers,
        awayPlayers: awayPlayers,
        lineupImage: lineupImage,
      );
    } catch (e) {
      if (kDebugMode) {
        print('FieldLineupResponse.fromJson: Error parsing JSON: $e');
        print('FieldLineupResponse.fromJson: JSON content: $json');
      }
      rethrow;
    }
  }
}

class FieldPlayer {
  final String playerName;
  final int playerNumber;
  final String playerId;
  final String playerPosition;
  final String teamName;
  final String unitGroup;
  final double starterProbability;
  final int starterPrediction;

  FieldPlayer({
    required this.playerName,
    required this.playerNumber,
    required this.playerId,
    required this.playerPosition,
    required this.teamName,
    required this.unitGroup,
    required this.starterProbability,
    required this.starterPrediction,
  });

  factory FieldPlayer.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print(
        'FieldPlayer.fromJson: Parsing player: ${json['player_name'] ?? 'Unknown'}',
      );
    }

    try {
      return FieldPlayer(
        playerName: json['player_name']?.toString() ?? '',
        playerNumber:
            json['player_number'] is int
                ? json['player_number']
                : (json['player_number'] is double
                    ? (json['player_number'] as double).toInt()
                    : int.tryParse(json['player_number']?.toString() ?? '0') ??
                        0),
        playerId: json['player_id']?.toString() ?? '',
        playerPosition: json['player_position']?.toString() ?? '',
        teamName: json['team_name']?.toString() ?? '',
        unitGroup: json['unit_group']?.toString() ?? '',
        starterProbability:
            json['starter_probability'] is double
                ? json['starter_probability']
                : json['starter_probability'] is int
                ? (json['starter_probability'] as int).toDouble()
                : double.tryParse(
                      json['starter_probability']?.toString() ?? '0.0',
                    ) ??
                    0.0,
        starterPrediction:
            json['starter_prediction'] is int
                ? json['starter_prediction']
                : (json['starter_prediction'] is double
                    ? (json['starter_prediction'] as double).toInt()
                    : int.tryParse(
                          json['starter_prediction']?.toString() ?? '0',
                        ) ??
                        0),
      );
    } catch (e) {
      if (kDebugMode) {
        print('FieldPlayer.fromJson: Error parsing player: $e');
        print('FieldPlayer.fromJson: Player JSON: $json');
      }
      rethrow;
    }
  }
}
