import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/mlb_controller.dart';
import 'dart:convert';

class MlbPlayersWidget extends StatelessWidget {
  const MlbPlayersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('MlbPlayersWidget is building');
    final MlbPlayerController controller = Get.put(MlbPlayerController());

    // Fetch lineup and image for a default team if not already loaded
    if (controller.imageBase64.value.isEmpty && !controller.isLoading.value) {
      controller.fetchLineupAndImage('Boston Red Sox');
    }

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.imageBase64.value.isEmpty) {
        return Center(child: Image.asset('assets/icons/mlb.png'));
      }
      return Center(
        child: Image.memory(base64Decode(controller.imageBase64.value)),
      );
    });
  }
}
