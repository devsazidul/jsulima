import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/field_controller.dart';

class FieldWidget extends StatelessWidget {
  final FieldController controller = Get.put(FieldController());

  FieldWidget({super.key});

  Widget _buildPlayerCircle(PlayerModel player) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: player.color,
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

  @override
  Widget build(BuildContext context) {
    const double fieldWidth = 350;
    const double fieldHeight = 560;

    return Center(
      child: SizedBox(
        width: fieldWidth,
        height: fieldHeight,
        child: Stack(
          children: [
            // Use only the image as the field
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/field.jpg'),
                  fit: BoxFit.cover, // Ensure image covers the field
                ),
              ),
            ),
            Obx(
              () => Stack(
                children:
                    controller.players.map((player) {
                      final pos = player.position.value;
                      if (pos.dx.isNaN ||
                          pos.dy.isNaN ||
                          pos.dx.isInfinite ||
                          pos.dy.isInfinite) {
                        player.position.value = const Offset(100, 100);
                      }
                      print(
                        'Rendering player ${player.number} at ${pos.dx}, ${pos.dy}',
                      ); // Debug log
                      return Positioned(
                        left: pos.dx,
                        top: pos.dy,
                        child: Draggable<PlayerModel>(
                          data: player,
                          feedback: _buildPlayerCircle(player),
                          childWhenDragging: Opacity(
                            opacity: 0.5,
                            child: _buildPlayerCircle(player),
                          ),
                          onDraggableCanceled: (_, offset) {
                            final validOffset = Offset(
                              offset.dx.clamp(0, fieldWidth - 40),
                              offset.dy.clamp(0, fieldHeight - 40),
                            );
                            controller.movePlayer(player, validOffset);
                          },
                          child: _buildPlayerCircle(player),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
