import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:shimmer/shimmer.dart';

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
                Obx(() {
                  return CircleAvatar(
                    radius: 50,
                    child: ClipOval(
                      child: controller.image.value.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: controller.image.value,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) {
                                debugPrint(
                                  'Image load error: $error for URL: $url',
                                );
                                return Image.asset(
                                  ImagePath.profileImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              ImagePath.profileImage,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                    ),
                  );
                }),
                SizedBox(height: 10),
                Obx(
                  () => Text(
                    controller.name.value,
                    style: getTextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => Text(
                    controller.username.value,
                    style: getTextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => Text(
                    controller.email.value, // Added email display
                    style: getTextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
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
                InkWell(
                  onTap: () {
                    controller.logout();
                  },
                  child: ProfileTileWidget(
                    title: "Log Out",
                    icon: Icons.power_settings_new,
                    isLogout: true,
                  ),
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