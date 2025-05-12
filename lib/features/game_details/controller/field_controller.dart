import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PlayerModel {
  final String name;
  final String role;
  final int number;
  final Color color;
  Rx<Offset> position;

  PlayerModel({
    required this.name,
    required this.role,
    required this.number,
    required this.color,
    required Offset initialPosition,
  }) : position = initialPosition.obs;

  get id => null;
}

class FieldController extends GetxController {
  var players = <PlayerModel>[].obs;
  var positions = <int, Offset>{}.obs;

  @override
  void onReady() {
    super.onReady();
    _initializePlayers();
  }

  void _initializePlayers() {
    const double fieldWidth = 350;
    const double fieldHeight = 560;

    // 4-3-3 formation for red players (Team 1, left half)
    final List<PlayerModel> redPlayers = [
      PlayerModel(
        name: 'Ryan',
        role: 'PR',
        number: 1,
        color: Colors.red,
        initialPosition: const Offset(50, 140),
      ),
      PlayerModel(
        name: 'Smith',
        role: 'HK',
        number: 2,
        color: Colors.red,
        initialPosition: const Offset(80, 140),
      ),
      PlayerModel(
        name: 'Jones',
        role: 'PR',
        number: 3,
        color: Colors.red,
        initialPosition: const Offset(110, 140),
      ),
      PlayerModel(
        name: 'Brown',
        role: 'LK',
        number: 4,
        color: Colors.red,
        initialPosition: const Offset(50, 210),
      ),
      PlayerModel(
        name: 'Davis',
        role: 'LK',
        number: 5,
        color: Colors.red,
        initialPosition: const Offset(110, 210),
      ),
      PlayerModel(
        name: 'Wilson',
        role: 'FL',
        number: 6,
        color: Colors.red,
        initialPosition: const Offset(50, 280),
      ),
      PlayerModel(
        name: 'Moore',
        role: 'FL',
        number: 7,
        color: Colors.red,
        initialPosition: const Offset(80, 280),
      ),
      PlayerModel(
        name: 'Taylor',
        role: 'N8',
        number: 8,
        color: Colors.red,
        initialPosition: const Offset(110, 280),
      ),
      PlayerModel(
        name: 'Clark',
        role: 'SH',
        number: 9,
        color: Colors.red,
        initialPosition: const Offset(50, 350),
      ),
      PlayerModel(
        name: 'Adams',
        role: 'FH',
        number: 10,
        color: Colors.red,
        initialPosition: const Offset(80, 350),
      ),
      PlayerModel(
        name: 'Harris',
        role: 'CE',
        number: 11,
        color: Colors.red,
        initialPosition: const Offset(110, 350),
      ),
    ];

    // 4-3-3 formation for black players (Team 2, right half)
    final List<PlayerModel> blackPlayers = [
      PlayerModel(
        name: 'Evans',
        role: 'PR',
        number: 12,
        color: Colors.black,
        initialPosition: const Offset(200, 140),
      ),
      PlayerModel(
        name: 'Lewis',
        role: 'HK',
        number: 13,
        color: Colors.black,
        initialPosition: const Offset(230, 140),
      ),
      PlayerModel(
        name: 'King',
        role: 'PR',
        number: 14,
        color: Colors.black,
        initialPosition: const Offset(260, 140),
      ),
      PlayerModel(
        name: 'Allen',
        role: 'LK',
        number: 15,
        color: Colors.black,
        initialPosition: const Offset(200, 210),
      ),
      PlayerModel(
        name: 'Green',
        role: 'LK',
        number: 16,
        color: Colors.black,
        initialPosition: const Offset(260, 210),
      ),
      PlayerModel(
        name: 'Hill',
        role: 'FL',
        number: 17,
        color: Colors.black,
        initialPosition: const Offset(200, 280),
      ),
      PlayerModel(
        name: 'Turner',
        role: 'FL',
        number: 18,
        color: Colors.black,
        initialPosition: const Offset(230, 280),
      ),
      PlayerModel(
        name: 'Parker',
        role: 'N8',
        number: 19,
        color: Colors.black,
        initialPosition: const Offset(260, 280),
      ),
      PlayerModel(
        name: 'Young',
        role: 'SH',
        number: 20,
        color: Colors.black,
        initialPosition: const Offset(200, 350),
      ),
      PlayerModel(
        name: 'White',
        role: 'FH',
        number: 21,
        color: Colors.black,
        initialPosition: const Offset(230, 350),
      ),
      PlayerModel(
        name: 'Martin',
        role: 'CE',
        number: 22,
        color: Colors.black,
        initialPosition: const Offset(260, 350),
      ),
    ];

    players.value = [
      ...redPlayers,
      ...blackPlayers,
    ]; // Include both red and black players

    // Initialize positions map
    for (var player in players) {
      positions[player.number] = player.position.value;
    }
  }

  void movePlayer(PlayerModel player, Offset newPosition) {
    player.position.value = newPosition;
    positions[player.number] = newPosition;
  }
}
