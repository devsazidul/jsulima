import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class LeagueButtonWidget extends StatelessWidget {
  final String league;
  final String iconPath;

  const LeagueButtonWidget({
    super.key,
    required this.league,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return GestureDetector(
      onTap: () => controller.selectLeague(league),
      child: Obx(() {
        bool isSelected = controller.selectedLeague.value == league;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                league,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6),
              Image.asset(iconPath, width: 40, height: 35),
            ],
          ),
        );
      }),
    );
  }
}
