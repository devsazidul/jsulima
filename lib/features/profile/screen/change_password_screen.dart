import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/widgets/custom_button.dart';

import 'package:jsulima/features/profile/controller/change_password_controller.dart';
import 'package:jsulima/features/profile/widgest/password_field_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final ChangePasswordController controller = Get.put(
    ChangePasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Change Password",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Obx(
                    () => PasswordFieldWidget(
                      controller: controller.currentPasswordController,
                      hint: "Current Password",
                      isObscured: controller.isCurrentObscured.value,
                      toggleVisibility:
                          () => controller.toggleObscure('current'),
                    ),
                  ),
                  Obx(
                    () => PasswordFieldWidget(
                      controller: controller.newPasswordController,
                      hint: "New Password",
                      isObscured: controller.isNewObscured.value,
                      toggleVisibility: () => controller.toggleObscure('new'),
                    ),
                  ),
                  Obx(
                    () => PasswordFieldWidget(
                      controller: controller.confirmPasswordController,
                      hint: "Retype New Password",
                      isObscured: controller.isConfirmObscured.value,
                      toggleVisibility:
                          () => controller.toggleObscure('confirm'),
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    vertical: 20,
                    text: "Save Changes",
                    onPressed: () {
                      controller.saveChanges();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
