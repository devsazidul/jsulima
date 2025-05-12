import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/mlb_controller.dart';

class MlbPlayersWidget extends StatelessWidget {
  const MlbPlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MlbPlayerController controller = Get.put(MlbPlayerController());

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          width: 400,
          height: 600,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mlb_field.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children:
                controller.players.map((player) {
                  return PlayerWidget(
                    player: player,
                    onPositionChanged: (newPosition) {
                      controller.updatePlayerPosition(player.id, newPosition);
                    },
                  );
                }).toList(),
          ),
        ),
      );
    });
  }
}

class PlayerWidget extends StatelessWidget {
  final Player player;
  final Function(Offset) onPositionChanged;

  const PlayerWidget({
    Key? key,
    required this.player,
    required this.onPositionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MlbPlayerController>();
    final screenBounds = controller.getScreenBounds();
    final maxWidth = 600;
    final maxHeight = 200;

    return Positioned(
      left: player.position.dx,
      top: player.position.dy,
      child: Draggable(
        feedback: _buildPlayer(),
        childWhenDragging: Container(),
        onDragEnd: (details) {
          final newX = details.offset.dx.clamp(0.0, maxWidth) as double;
          final newY = details.offset.dy.clamp(0.0, maxHeight) as double;
          onPositionChanged(Offset(newX, newY));
        },
        child: _buildPlayer(),
      ),
    );
  }

  Widget _buildPlayer() {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Center(
        child: Text(
          player.id,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
