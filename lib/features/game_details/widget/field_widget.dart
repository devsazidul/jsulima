import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/field_controller.dart';

class FieldWidget extends StatelessWidget {

  const FieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
  final FieldController controller = Get.put(FieldController());
    if (controller.imageBase64.value.isEmpty && !controller.isLoading.value) {
      controller.fetchLineupAndImage('Arizona Cardinals',  'Atlanta Falcons');
    }

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
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
