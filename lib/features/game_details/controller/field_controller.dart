import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PlayerModel {
  final int number;
  final Color color;
  Rx<Offset> position;

  PlayerModel({
    required this.number,
    required this.color,
    required Offset initialPosition,
  }) : position = initialPosition.obs;
}

class FieldController extends GetxController {
  var players = <PlayerModel>[].obs;
  var positions = <int, Offset>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayers();
  }

  void _initializePlayers() {
    // const double fieldWidth = 800;
    // const double fieldHeight = 560;

    // 4-3-3 formation for red players (Team 1, left half)

    // 4-3-3 formation for black players (Team 2, right half)
    final List<PlayerModel> blackPlayers = [
      PlayerModel(
        number: 12,
        color: Colors.black,
        initialPosition: Offset(600, 140),
      ),
      PlayerModel(
        number: 13,
        color: Colors.black,
        initialPosition: Offset(650, 140),
      ),
      PlayerModel(
        number: 14,
        color: Colors.black,
        initialPosition: Offset(700, 140),
      ),
      PlayerModel(
        number: 15,
        color: Colors.black,
        initialPosition: Offset(600, 210),
      ),
      PlayerModel(
        number: 16,
        color: Colors.black,
        initialPosition: Offset(700, 210),
      ),
      PlayerModel(
        number: 17,
        color: Colors.black,
        initialPosition: Offset(600, 280),
      ),
      PlayerModel(
        number: 18,
        color: Colors.black,
        initialPosition: Offset(650, 280),
      ),
      PlayerModel(
        number: 19,
        color: Colors.black,
        initialPosition: Offset(700, 280),
      ),
      PlayerModel(
        number: 20,
        color: Colors.black,
        initialPosition: Offset(600, 350),
      ),
      PlayerModel(
        number: 21,
        color: Colors.black,
        initialPosition: Offset(650, 350),
      ),
      PlayerModel(
        number: 22,
        color: Colors.black,
        initialPosition: Offset(700, 350),
      ),
    ];
    final List<PlayerModel> redPlayers = [
      PlayerModel(
        number: 1,
        color: Colors.red,
        initialPosition: Offset(50, 140),
      ),
      PlayerModel(
        number: 2,
        color: Colors.red,
        initialPosition: Offset(100, 140),
      ),
      PlayerModel(
        number: 3,
        color: Colors.red,
        initialPosition: Offset(150, 140),
      ),
      PlayerModel(
        number: 4,
        color: Colors.red,
        initialPosition: Offset(50, 210),
      ),
      PlayerModel(
        number: 5,
        color: Colors.red,
        initialPosition: Offset(150, 210),
      ),
      PlayerModel(
        number: 6,
        color: Colors.red,
        initialPosition: Offset(50, 280),
      ),
      PlayerModel(
        number: 7,
        color: Colors.red,
        initialPosition: Offset(100, 280),
      ),
      PlayerModel(
        number: 8,
        color: Colors.red,
        initialPosition: Offset(150, 280),
      ),
      PlayerModel(
        number: 9,
        color: Colors.red,
        initialPosition: Offset(50, 350),
      ),
      PlayerModel(
        number: 10,
        color: Colors.red,
        initialPosition: Offset(100, 350),
      ),
      PlayerModel(
        number: 11,
        color: Colors.red,
        initialPosition: Offset(150, 350),
      ),
    ];

    players.value = [...redPlayers];

    // Initialize positions map
    for (var player in players) {
      positions[player.number] = player.position.value;
      print(player.number);
    }
  }

  void movePlayer(PlayerModel player, Offset newPosition) {
    player.position.value = newPosition;
    positions[player.number] = newPosition;
  }
}
