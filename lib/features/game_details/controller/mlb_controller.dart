import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Player {
  final String id;
  Offset position;
  final String? imagePath;
  Player({required this.id, required this.position, this.imagePath});
}
class MlbPlayerController extends GetxController {
  final RxList<Player> _players = <Player>[].obs;
  List<Player> get players => _players;
  double _fieldWidth = 0;
  double _fieldHeight = 0;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayers();
    });
  }
  void setFieldSize(double width, double height) {
    _fieldWidth = width;
    _fieldHeight = height;
    if (_players.isNotEmpty) {
      _initializePlayers();
    }
  }
  void _initializePlayers() {
    if (_fieldWidth == 0 || _fieldHeight == 0) {
      _fieldWidth = Get.context?.mediaQuery.size.width ?? 400;
      _fieldHeight = Get.context?.mediaQuery.size.height ?? 600;
    }
    final centerX = _fieldWidth / 2;
    final centerY = _fieldHeight / 2;

    _players.assignAll([
      Player(id: 'P', position: Offset(centerX - 50, centerY - 100)), // Pitcher
      Player(id: 'C', position: Offset(centerX, centerY)), 
      Player(
        id: '1B',
        position: Offset(centerX + 100, centerY - 50),
      ),
      Player(
        id: '2B',
        position: Offset(centerX - 100, centerY + 50),
      ), 
      Player(
        id: '2B',
        position: Offset(centerX + 100, centerY + 50),
      ), 
      Player(
        id: '3B',
        position: Offset(centerX - 150, centerY - 50),
      ), 
      Player(
        id: 'LF',
        position: Offset(centerX - 200, centerY - 150),
      ),
      Player(
        id: 'CF',
        position: Offset(centerX, centerY - 200),
      ),
      Player(
        id: 'RF',
        position: Offset(centerX + 200, centerY - 150),
      ),
    ]);
  }
  void updatePlayerPosition(String id, Offset newPosition) {
    final playerIndex = _players.indexWhere((p) => p.id == id);
    if (playerIndex != -1) {
      final newX = newPosition.dx.clamp(0.0, _fieldWidth - 50);
      final newY = newPosition.dy.clamp(0.0, _fieldHeight - 50);
      _players[playerIndex].position = Offset(newX, newY);
      _players.refresh();
    }
  }
  Future<void> animatePlayerTo(
    String id,
    Offset targetPosition,
    Duration duration,
  ) async {
    final playerIndex = _players.indexWhere((p) => p.id == id);
    if (playerIndex != -1) {
      final player = _players[playerIndex];
      final targetX = targetPosition.dx.clamp(0.0, _fieldWidth - 50);
      final targetY = targetPosition.dy.clamp(0.0, _fieldHeight - 50);
      final startPosition = player.position;
      const steps = 20;
      final dxStep = (targetX - startPosition.dx) / steps;
      final dyStep = (targetY - startPosition.dy) / steps;

      for (int i = 1; i <= steps; i++) {
        await Future.delayed(
          Duration(milliseconds: duration.inMilliseconds ~/ steps),
        );
        player.position = Offset(
          startPosition.dx + dxStep * i,
          startPosition.dy + dyStep * i,
        );
        _players.refresh();
      }
    }
  }
  (double maxWidth, double maxHeight) getScreenBounds() {
    return (_fieldWidth - 50, _fieldHeight - 50);
  }
}
