import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart';
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/profile/controller/profile_info_controller.dart';
import 'package:jsulima/features/profile/controller/notifications_controller.dart';
import 'package:jsulima/features/profile/screen/change_password_screen.dart';
import 'package:jsulima/features/profile/screen/personal_info_screen.dart';
import 'package:jsulima/features/profile/widgest/profile_tile_widget.dart';
import 'package:jsulima/features/subscription/screen/subscription_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileInfoController controller = Get.put(ProfileInfoController());
  final NotificationsController controller2 = Get.put(
    NotificationsController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 65, left: 16, right: 16, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(ImagePath.profileImage),
                ),
                SizedBox(height: 10),
                Text(
                  controller.fullName,
                  style: getTextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  controller.userNameStatic,
                  style: getTextStyle(color: Colors.grey),
                ),
                SizedBox(height: 30),
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

                GestureDetector(
                  onTap: () {
                    Get.to(SubscriptionScreen()); 
                  },
                  child: ProfileTileWidget(
                    title: "Subscription",
                    icon: Icons.arrow_forward,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => ChangePasswordScreen()),
                  child: ProfileTileWidget(
                    title: "Change Password",
                    icon: Icons.arrow_forward,
                  ),
                ),
                SizedBox(height: 20),
                ProfileTileWidget(
                  title: "Log Out",
                  icon: Icons.power_settings_new,
                  isLogout: true,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
