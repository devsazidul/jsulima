import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jsulima/features/game_details/controller/game_details_controller.dart';
import 'package:jsulima/features/game_details/widget/details/tab_item.dart';

class TabNavigation extends StatelessWidget {
  final GameDetailsController gameDetailsController;

  const TabNavigation({super.key, required this.gameDetailsController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabItem(
                label: 'Prediction',
                index: 0,
                onTap: () => gameDetailsController.updateSelectedIndex(0),
                selectedIndex: gameDetailsController.selectedIndex,
              ),
              SizedBox(width: 47.67),
              TabItem(
                label: 'Players',
                index: 1,
                onTap: () => gameDetailsController.updateSelectedIndex(1),
                selectedIndex: gameDetailsController.selectedIndex,
              ),
              SizedBox(width: 47.67),
              TabItem(
                label: 'Line Up',
                index: 2,
                onTap: () => gameDetailsController.updateSelectedIndex(2),
                selectedIndex: gameDetailsController.selectedIndex,
              ),
              SizedBox(width: 47.67),
              TabItem(
                label: 'State',
                index: 3,
                onTap: () => gameDetailsController.updateSelectedIndex(3),
                selectedIndex: gameDetailsController.selectedIndex,
              ),
            ],
          ),
        ),
        Obx(() {
          return Positioned(
            left:
                gameDetailsController.selectedIndex.value *
                (MediaQuery.of(context).size.width / 4),
            bottom: 0,
            child: Container(
              height: 6,
              width: 79,
              decoration: BoxDecoration(
                color: Color(0xFFCA0101),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
