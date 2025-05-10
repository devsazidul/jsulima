import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/core/utils/constants/image_path.dart';
import 'package:jsulima/features/game_details/controller/game_details_controller.dart';
import 'package:jsulima/features/game_details/widget/player_tab_container.dart';
import 'package:jsulima/features/game_details/widget/prediction_tab_widget.dart';
import 'package:jsulima/features/game_details/widget/state_tab_container.dart';

class GameDetailsContainer extends StatelessWidget {
  final double team1Percentage;
  final double team2Percentage;
  const GameDetailsContainer({
    super.key,
    required this.team1Percentage,
    required this.team2Percentage,
  });

  @override
  Widget build(BuildContext context) {
    final GameDetailsController gameDetailsController = Get.put(
      GameDetailsController(),
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                height: 330,
                width: 402,
                "assets/images/playground.png",
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 115,
                  left: 28,
                  right: 28,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          ImagePath.atlantaFalcon,
                          height: 76,
                          width: 80,
                        ),
                        Spacer(),
                        Text(
                          'VS',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 32,
                            height: 1.2,
                            color: Color(0xFFFFFFFF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Image.asset(
                          ImagePath.carolinaPanther,
                          height: 76,
                          width: 80,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Atlanta\nFalcon',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.2,
                            color: Color(0xFFFFFFFF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),

                        Text(
                          "14 Feb\n3:00 PM",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            height: 1.4,
                            color: Color(0xFFFFFFFF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        SizedBox(height: 8),
                        Text(
                          'Carolina\nPanther',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            height: 1.2,
                            color: Color(0xFFFFFFFF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Atlanta Falcon",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${team1Percentage.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                                letterSpacing: 0,
                                color: Color(0xFFC60C30),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 4),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Carolina Panther',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${team2Percentage.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.5,
                                letterSpacing: 0,
                                color: Color(0xFF216AFD),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: (team1Percentage).toInt(),
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(color: Color(0xFFC60C30)),
                          ),
                        ),
                        SizedBox(width: 3),
                        Expanded(
                          flex: (team2Percentage).toInt(),
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(color: Color(0xFF216AFD)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'AI Confidence',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        height: 1.3,
                        color: Color(0xFFFFFFFF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 16),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 11,
                      ),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFFCA0101),
                        borderRadius: BorderRadius.circular(72),
                      ),
                      child: Text(
                        '85%',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          height: 1.3,
                          color: Color(0xFFFFFFFF),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          height: 1.5,
                          color: Color(0xFFEBEBEB),
                        ),
                        children: <TextSpan>[
                          TextSpan(text: 'Venue: '),
                          TextSpan(
                            text: ' Allegiant Stadium',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFFCA0101),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Stack(
                  children: [
                    SizedBox(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              gameDetailsController.updateSelectedIndex(0);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(() {
                                  return Text(
                                    ' Prediction',
                                    style: TextStyle(
                                      color:
                                          gameDetailsController
                                                      .selectedIndex
                                                      .value ==
                                                  0
                                              ? Color(0xFFCA0101)
                                              : Color(0xFFABABAB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                    ),
                                    textAlign: TextAlign.center,
                                  );
                                }),
                                SizedBox(height: 6),
                              ],
                            ),
                          ),
                          SizedBox(width: 47.67),
                          GestureDetector(
                            onTap: () {
                              gameDetailsController.updateSelectedIndex(1);
                            },
                            child: Obx(() {
                              return Text(
                                'Players',
                                style: TextStyle(
                                  color:
                                      gameDetailsController
                                                  .selectedIndex
                                                  .value ==
                                              1
                                          ? Color(0xFFCA0101)
                                          : Color(0xFFABABAB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }),
                          ),
                          SizedBox(width: 47.67),
                          GestureDetector(
                            onTap: () {
                              gameDetailsController.updateSelectedIndex(2);
                            },
                            child: Obx(() {
                              return Text(
                                'Line Up',
                                style: TextStyle(
                                  color:
                                      gameDetailsController
                                                  .selectedIndex
                                                  .value ==
                                              2
                                          ? Color(0xFFCA0101)
                                          : Color(0xFFABABAB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }),
                          ),
                          SizedBox(width: 47.67),
                          GestureDetector(
                            onTap: () {
                              gameDetailsController.updateSelectedIndex(3);
                            },
                            child: Obx(() {
                              return Text(
                                'State',
                                style: TextStyle(
                                  color:
                                      gameDetailsController
                                                  .selectedIndex
                                                  .value ==
                                              3
                                          ? Color(0xFFCA0101)
                                          : Color(0xFFABABAB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              );
                            }),
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
                ),
                SizedBox(height: 24),
                Obx(() {
                  if (gameDetailsController.selectedIndex.value == 0) {
                    return PredictionContainer();
                  } else if (gameDetailsController.selectedIndex.value == 1) {
                    return PlayerTabContainer();
                  } else if (gameDetailsController.selectedIndex.value == 2) {
                    return Container();
                  } else {
                    return StateTabContainer(team1Win: 3, team2Win: 2, draw: 0);
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
