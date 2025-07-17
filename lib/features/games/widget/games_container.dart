import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/services/match_service.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';
import 'package:jsulima/features/games/widget/prediction_container.dart';

class GamesContainer extends StatelessWidget {
  GamesContainer({super.key});

  final GameController buttonController = Get.put(GameController());
  final MatchService matchService = MatchService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
        height: double.infinity,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Games",
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF393939),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search ...",
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFABB7C2),
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 11.5,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Container(
                  height: 50,
                  width: 48,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF393939),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    "assets/icons/search.png",
                    height: 16,
                    width: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    buttonController.onButtonClick(0);
                  },
                  child: Obx(() {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      height: 40,
                      width: 96,
                      decoration: BoxDecoration(
                        color: buttonController.selectedButton.value == 0
                            ? Color(0xFFFFFFFF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: buttonController.selectedButton.value == 0
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Color(0xEBEBEBEB)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'NFL',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(width: 11.6),
                          Image.asset(
                            'assets/images/Group.png',
                            height: 23,
                            width: 16.72,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    buttonController.onButtonClick(1);
                  },
                  child: Obx(() {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      height: 40,
                      width: 96,
                      decoration: BoxDecoration(
                        color: buttonController.selectedButton.value == 1
                            ? Color(0xFFFFFFFF)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: buttonController.selectedButton.value == 1
                            ? Border.all(color: Colors.transparent)
                            : Border.all(color: Color(0xEBEBEBEB)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'MLB',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(width: 11.6),
                          Image.asset(
                            'assets/images/team.png',
                            height: 23,
                            width: 16.72,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 40.0),
            Expanded(
              child: Obx(() {
                if (buttonController.selectedButton.value == 0) {
                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: matchService.fetchNFLGames(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No NFL games available'));
                      }
                      final nflGameList = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: nflGameList.length,
                        itemBuilder: (context, index) {
                          var game = nflGameList[index];
                          return PredictionContainer(
                            team1Name: game['team1Name']!,
                            team2Name: game['team2Name']!,
                            team1Image: game['team1Image']!,
                            team2Image: game['team2Image']!,
                            matchTime: game['matchTime']!,
                            predictionText: game['predictionText']!,
                            team1Percentage: game['team1Percentage']!,
                            team2Percentage: game['team2Percentage']!,
                          );
                        },
                      );
                    },
                  );
                } else {
                  return FutureBuilder<List<Map<String, dynamic>>>(
                    future: matchService.fetchMLBGames(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No MLB games available'));
                      }
                      final mlbGameList = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: mlbGameList.length,
                        itemBuilder: (context, index) {
                          var game = mlbGameList[index];
                          return PredictionContainer(
                            team1Name: game['team1Name']!,
                            team2Name: game['team2Name']!,
                            team1Image: game['team1Image']!,
                            team2Image: game['team2Image']!,
                            matchTime: game['matchTime']!,
                            predictionText: game['predictionText']!,
                            team1Percentage: game['team1Percentage']!,
                            team2Percentage: game['team2Percentage']!,
                          );
                        },
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}