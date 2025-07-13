import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/colors.dart';
import 'package:jsulima/features/profile/controller/profile_info_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  late final ProfileInfoController controller;

  PersonalInfoScreen({super.key}) {
    controller = Get.put(ProfileInfoController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splashImage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    _buildEditableTile('Name', controller.name),
                    _buildEditableTile('User Name', controller.username),
                    _buildEditableTile('Email', controller.email),
                    _buildEditableTile('Phone Number', controller.phoneNumber),
                    _buildEditableTile('Country', controller.country),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTile(String label, RxString value) {
    final isEditing = controller.isEditing.value == label;
    final controllerField = TextEditingController(text: value.value);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 4),
                isEditing
                    ? TextField(
                        controller: controllerField,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        onSubmitted: (val) => controller.updateValue(label, val),
                        autofocus: true,
                      )
                    : Text(
                        value.value,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isEditing) {
                controller.updateValue(label, controllerField.text);
              } else {
                controller.startEditing(label);
              }
            },
            child: const Icon(
              Icons.edit,
              size: 18,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}