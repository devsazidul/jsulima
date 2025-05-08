import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/profile/controller/field_controller.dart';

class FieldWidget extends StatelessWidget {
  final PlayerModel player;

  const FieldWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        left: player.position.value.dx,
        top: player.position.value.dy,
        child: Draggable<PlayerModel>(
          data: player,
          feedback: _buildPlayerCircle(),
          childWhenDragging: Opacity(opacity: 0.5, child: _buildPlayerCircle()),
          onDraggableCanceled: (_, offset) {
            player.position.value = offset;
          },
          child: _buildPlayerCircle(),
        ),
      ),
    );
  }

  Widget _buildPlayerCircle() {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        '${player.number}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
