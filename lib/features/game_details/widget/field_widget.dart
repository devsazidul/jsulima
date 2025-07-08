import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/field_controller.dart';
import 'package:shimmer/shimmer.dart';

class FieldWidget extends StatelessWidget {
  final String team1Name;
  final String team2Name;
  const FieldWidget({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  Widget build(BuildContext context) {
    final FieldController controller = Get.put(FieldController());
    controller.fetchLineupAndImage(team1Name, team2Name);
    if (controller.imageBase64.value.isEmpty && !controller.isLoading.value) {
      controller.fetchLineupAndImage(team1Name, team2Name);
    }

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      }
      if (controller.imageBase64.value.isEmpty) {
        return Center(child: Image.asset('assets/icons/nlf.png'));
      }
      return Center(
        child: Image.memory(base64Decode(controller.imageBase64.value)),
      );
    });
  }
}
