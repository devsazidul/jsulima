import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/controller/game_details_controller.dart';
import 'package:jsulima/features/game_details/widget/player_tab_container.dart';
import 'package:jsulima/features/game_details/widget/prediction_tab_widget.dart';
import 'package:jsulima/features/game_details/widget/state_tab_container.dart';
import 'package:jsulima/features/game_details/widget/tuneup_screen.dart';

class TabNavigation extends StatefulWidget {
  final String team1Name;
  final String team2Name;

  const TabNavigation({
    super.key,
    required this.team1Name,
    required this.team2Name,
  });

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation>
    with TickerProviderStateMixin {
  final GameDetailsController controller = Get.find<GameDetailsController>();

  @override
  void initState() {
    super.initState();
    controller.initializeTabController(this);
  }

  @override
  void dispose() {
    controller.disposeTabController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tabController = controller.tabController.value;
      if (tabController == null) {
        return SizedBox.shrink();
      }

      return Column(
        children: [
          TabBar(
            controller: tabController,
            onTap: (index) => controller.updateSelectedIndex(index),
            indicatorColor: Color(0xFFCA0101),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 6, color: Color(0xFFCA0101)),
              insets: EdgeInsets.only(bottom: 0),
            ),
            labelColor: Color(0xFFCA0101),
            unselectedLabelColor: Color(0xFFABABAB),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            tabs: [
              Tab(text: 'Prediction'),
              Tab(text: 'Players'),
              Tab(text: 'Line Up'),
              Tab(text: 'State'),
            ],
          ),
          SizedBox(height: 24),
          Container(
            height: MediaQuery.of(context).size.height * 0.6, // Fixed height
            child: IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                SingleChildScrollView(child: PredictionContainer()),
                SingleChildScrollView(child: PlayerTabContainer()),
                SingleChildScrollView(
                  child: TuneupScreen(
                    team1Name: widget.team1Name,
                    team2Name: widget.team2Name,
                  ),
                ),
                SingleChildScrollView(
                  child: StateTabContainer(team1Win: 3, team2Win: 2, draw: 0),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
