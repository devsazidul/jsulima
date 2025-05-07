import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/profile/controller/profile_info_controller.dart';
import 'package:jsulima/features/profile/controller/notifications_controller.dart';
import 'package:jsulima/features/profile/screen/change_password_screen.dart';
import 'package:jsulima/features/profile/screen/personal_info_screen.dart';
import 'package:jsulima/features/profile/widgest/profile_tile_widget.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileInfoController controller = Get.put(ProfileInfoController());
  final NotificationsController controller2 = Get.put(
    NotificationsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
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
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.fullName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    controller.userNameStatic,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => Get.to(() => PersonalInfoScreen()),
                    child: ProfileTileWidget(
                      title: "Personal Information",
                      icon: Icons.arrow_forward,
                    ),
                  ),
                  Obx(
                    () => ProfileTileWidget(
                      title: "Notification Preferences",
                      icon: Icons.arrow_forward,
                      toggleValue: controller2.isNotificationEnabled.value,
                      onToggle: controller2.toggleNotification,
                    ),
                  ),
                  ProfileTileWidget(
                    title: "Subscription",
                    icon: Icons.arrow_forward,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => ChangePasswordScreen()),
                    child: ProfileTileWidget(
                      title: "Change Password",
                      icon: Icons.arrow_forward,
                    ),
                  ),
                  const Spacer(),
                  ProfileTileWidget(
                    title: "Log Out",
                    icon: Icons.power_settings_new,
                    isLogout: true,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
