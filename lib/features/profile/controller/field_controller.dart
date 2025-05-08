import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PlayerModel {
  final String name;
  final String role;
  final int number;
  Rx<Offset> position;

  PlayerModel({
    required this.name,
    required this.role,
    required this.number,
    required Offset initialPosition,
  }) : position = initialPosition.obs;
}

class FieldController extends GetxController {
  var players = <PlayerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializePlayers();
  }

  void _initializePlayers() {
    players.value = [
      PlayerModel(
        name: 'Ryan',
        role: 'QB',
        number: 2,
        initialPosition: Offset(100, 400),
      ),
      PlayerModel(
        name: 'Ridley',
        role: 'RB',
        number: 8,
        initialPosition: Offset(60, 360),
      ),
      PlayerModel(
        name: 'Jones',
        role: 'LB',
        number: 31,
        initialPosition: Offset(200, 100),
      ),
      // Add all others with unique Offset
    ];
  }

  void movePlayer(PlayerModel player, Offset newPosition) {
    player.position.value = newPosition;
  }
}
