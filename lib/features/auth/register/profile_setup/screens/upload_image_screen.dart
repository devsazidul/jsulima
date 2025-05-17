import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jsulima/core/common/styles/global_text_style.dart' show getTextStyle;
import 'package:jsulima/core/common/widgets/custom_button.dart';
import 'package:jsulima/core/utils/constants/colors.dart';
import 'package:jsulima/core/utils/constants/image_path.dart' show ImagePath;
import 'package:jsulima/features/auth/register/profile_setup/controller/profile_setup_controller.dart';

class UploadImageScreen extends StatelessWidget {
   UploadImageScreen({super.key});

  final ProfileSetupController controller = Get.put(ProfileSetupController());

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
          padding: EdgeInsets.only(
            top: 65, 
            left: 16, 
            right: 16, 
            bottom: 40
          ),
          child: Column(
            children: [
              Text("Upload Your\n Profile Picture", 
              textAlign: TextAlign.center,
               style: getTextStyle(
                color: Colors.white, 
                fontSize: 28, 
                fontWeight: FontWeight.w600
               ),
              ),
              SizedBox(
                height: 40,
              ), 
              Obx(
                () => InkWell(
                  onTap: (){
                    controller.pickImage();
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Color(0xFFD9D9D9),
                    backgroundImage: controller.selectedImagePath.value.isNotEmpty
                        ? FileImage(File(controller.selectedImagePath.value))
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ), 
              CustomButton(text: "Upload", onPressed: (){
                 controller.uploadProfileImage(); 
              }), 
              SizedBox(
                height: 16,
              ), 
              CustomButton(
                color: Colors.transparent,
                textColor: AppColors.primaryColor,
                text: "Skip", 
                onPressed: (){

                })
            ],
          ),
        ),
      ),
    );
  }
}