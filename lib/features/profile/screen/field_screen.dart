import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/profile/controller/field_controller.dart';
import 'package:jsulima/features/profile/widgest/field_widget.dart';

class FieldScreen extends StatelessWidget {
  final FieldController controller = Get.put(FieldController());

  FieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[800],
      body: Stack(
        children: [
          // Optional: Background lines or grid using Positioned widgets
          Obx(
            () => Stack(
              children:
                  controller.players
                      .map((player) => FieldWidget(player: player))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
