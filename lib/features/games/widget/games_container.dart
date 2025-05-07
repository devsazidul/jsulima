import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/games/controller/game_controller.dart';
import 'package:jsulima/features/games/widget/prediction_container.dart';

class GamesContainer extends StatelessWidget {
  GamesContainer({super.key});

  final GameController buttonController = Get.put(GameController());

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> gameList = [
      //Game 1
      {
        'team1Name': "New England Patriots",
        'team2Name': "Buffalo Bills",
        'team1Image': "assets/images/team1.png",
        'team2Image': "assets/images/team2.png",
        'matchTime': " 14 Feb\n3:00 PM",
        'predictionText':
            "Prediction: Mac Jones is predicted to throw for 275 yards, with 2 touchdowns and 1 interception in the upcoming game against the Buffalo Bills.",
        'team1Percentage': 30.0,
        'team2Percentage': 70.0,
      },
      //Game 2
      {
        'team1Name': "Green Bay Packers",
        'team2Name': "Chicago Bears",
        'team1Image': "assets/images/team1.png",
        'team2Image': "assets/images/team2.png",
        'matchTime': " 14 Feb\n6:30 PM",
        'predictionText':
            "Prediction: Aaron Rodgers is expected to pass for 300 yards, with 3 touchdowns and no interceptions against the Bears.",
        'team1Percentage': 65.0,
        'team2Percentage': 35.0,
      },
      //Game 3
      {
        'team1Name': "Dallas Cowboys",
        'team2Name': "New York Giants",
        'team1Image': "assets/images/team1.png",
        'team2Image': "assets/images/team2.png",
        'matchTime': " 15 Feb\n1:00 PM",
        'predictionText':
            "Prediction: Dak Prescott is forecasted to throw for 250 yards, with 2 touchdowns and 1 interception versus the Giants.",
        'team1Percentage': 70.0,
        'team2Percentage': 30.0,
      },
      //Game 4
      {
        'team1Name': "Miami Dolphins",
        'team2Name': "Tennessee Titans",
        'team1Image': "assets/images/team1.png",
        'team2Image': "assets/images/team2.png",
        'matchTime': " 16 Feb\n8:20 PM",
        'predictionText':
            "Prediction: Tua Tagovailoa is projected to pass for 295 yards, with 3 touchdowns and 1 interception against the Titans.",
        'team1Percentage': 75.0,
        'team2Percentage': 25.0,
      },
    ];

    return Container(
      margin: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
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
              Container(
                height: 50.0,
                width: 308.0,
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    height: 40,
                    width: 96,
                    decoration: BoxDecoration(
                      color:
                          buttonController.selectedButton.value == 0
                              ? Color(0xFFFFFFFF)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          buttonController.selectedButton.value == 0
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
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    height: 40,
                    width: 96,
                    decoration: BoxDecoration(
                      color:
                          buttonController.selectedButton.value == 1
                              ? Color(0xFFFFFFFF)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          buttonController.selectedButton.value == 1
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
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: gameList.length,
              itemBuilder: (context, index) {
                var game = gameList[index];
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
            ),
          ),
        ],
      ),
    );
  }
}
