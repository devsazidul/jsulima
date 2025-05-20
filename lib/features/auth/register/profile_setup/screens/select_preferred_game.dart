import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/utils/constants/colors.dart';
import 'package:jsulima/core/utils/constants/icon_path.dart';
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/auth/register/profile_setup/controller/profile_setup_controller.dart';
import 'package:jsulima/features/auth/register/profile_setup/screens/choose_your_plan_screen.dart';
import 'package:jsulima/features/auth/register/profile_setup/widgets/select_preferred_game_container.dart';

class SelectPreferredGame extends StatelessWidget {
  SelectPreferredGame({super.key});

  final ProfileSetupController controller = Get.find<ProfileSetupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 65, left: 16, right: 16, bottom: 40),
          child: Column(
            children: [
              Text(
                "Select Preferred\n Game",
                textAlign: TextAlign.center,
                style: getTextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() {
                    final isSelected = controller.selectedGame.value == "NFL";
                    return SelectPreferredGameContainer(
                      color: isSelected ? Colors.white : Colors.transparent,
                      textColor: isSelected ? Colors.black : Colors.white,
                      text: "NFL",
                      image: IconPath.nlf,
                      onTap: () => controller.toggleGameSelection("NFL"),
                    );
                  }),
                  Obx(() {
                    final isSelected = controller.selectedGame.value == "MLB";
                    return SelectPreferredGameContainer(
                      color: isSelected ? Colors.white : Colors.transparent,
                      textColor: isSelected ? Colors.black : Colors.white,
                      text: "MLB",
                      image: IconPath.mlb,
                      imageheight: 22,
                      imagewidth: 40,
                      onTap: () => controller.toggleGameSelection("MLB"),
                    );
                  }),
                ],
              ),
              SizedBox(height: 60),
              CustomButton(
                text: "Continue",
                onPressed: () {
                  Get.to(() => ChooseYourPlanScreen());
                },
              ),
              SizedBox(height: 16),
              CustomButton(
                color: Colors.transparent,
                textColor: AppColors.primaryColor,
                text: "Skip",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
