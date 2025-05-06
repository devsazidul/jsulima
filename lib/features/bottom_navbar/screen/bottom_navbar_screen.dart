import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/bottom_navbar/controller/bottom_navbar_controller.dart';

import 'package:jsulima/features/games/screen/games_screen.dart';

import 'package:jsulima/features/home/screen/home_screen.dart';


class BottomNavbarScreen extends StatelessWidget {
  BottomNavbarScreen({super.key});

  final BottomNavbarController controller = Get.put(BottomNavbarController());

  final List<Widget> screens = [
    HomeScreen(),
    GamesScreen(),
    Center(child: Text('Screen 3', style: TextStyle(color: Colors.white))),
    Center(child: Text('Screen 4', style: TextStyle(color: Colors.white))),
  ];

  final List<String> activeIcons = [
    ImagePath.activeHome,
    ImagePath.activeGames,
    ImagePath.activeNotification,
    ImagePath.activeProfile,
  ];

  final List<String> inactiveIcons = [
    ImagePath.inactiveHome,
    ImagePath.inactiveGames,
    ImagePath.inactiveNotification,
    ImagePath.inactiveProfile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D0D0F),
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          color: Color(0xFF0D0D0F),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(4, (index) {
                final isSelected = controller.selectedIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.changeIndex(index),
                  child: Image.asset(
                    isSelected ? activeIcons[index] : inactiveIcons[index],
                    width: 40,
                    height: 40,
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
