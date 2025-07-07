import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import 'package:flutter/foundation.dart' show kDebugMode;

class LeagueButtonWidget extends StatelessWidget {
  final String league;
  final String iconPath;
  final VoidCallback onTap; 

  const LeagueButtonWidget({
    super.key,
    required this.league,
    required this.iconPath,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    return GestureDetector(
      onTap: onTap, 
      child: Obx(() {
        if (kDebugMode) {
          print(
            "Building LeagueButtonWidget: $league, Selected League: ${controller.selectedLeague.value}",
          );
        }
        bool isSelected = controller.selectedLeague.value == league;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              const SizedBox(width: 6),
              Image.asset(iconPath, width: 40, height: 35),
            ],
          ),
        );
      }),
    );
  }
}