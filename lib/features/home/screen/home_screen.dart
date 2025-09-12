import 'dart:math' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jsulima/core/models/table_model.dart';
import 'package:jsulima/core/services/table_service.dart';
import 'package:jsulima/features/home/widgets/league_button_widget.dart';
import 'package:jsulima/features/home/widgets/match_card.dart';
import 'package:jsulima/features/home/widgets/table_row_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());
  final TableService tableService = TableService();

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2F2F2F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/icons/padlock.png', width: 60, height: 60),
                const SizedBox(height: 16),
                const Text(
                  'Coming soon is our Ultra VIP Consensus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please check back soon...',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Color(0xFF1A1A1A),
    body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splashImage.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: Get.height),
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search ...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey[850],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LeagueButtonWidget(
                          league: 'NFL',
                          iconPath: 'assets/icons/nlf.png',
                          onTap: () => controller.selectLeague('NFL'),
                        ),
                        const SizedBox(width: 10),
                        LeagueButtonWidget(
                          league: 'MLB',
                          iconPath: 'assets/icons/mlb.png',
                          onTap: () => controller.selectLeague('MLB'),
                        ),
                        const SizedBox(width: 10),
                        LeagueButtonWidget(
                          league: 'Vault',
                          iconPath: 'assets/icons/padlock.png',
                          onTap: () => _showComingSoonDialog(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () =>
                        controller.selectedLeague.value == 'NFL'
                            ? controller.isLoadingNflGames.value
                                ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: Get.width,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                )
                                : controller.nflGames.isEmpty
                                ? const Center(
                                  child: Text(
                                    'No NFL games available',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                                : MatchCard(
                                  team1Name:
                                      controller.nflGames[0]['team1Name'],
                                  team1LogoPath:
                                      controller.nflGames[0]['team1Image'],
                                  team2Name:
                                      controller.nflGames[0]['team2Name'],
                                  team2LogoPath:
                                      controller.nflGames[0]['team2Image'],
                                  matchDateTime: _parseMatchTime(
                                    controller.nflGames[0]['matchTime'],
                                  ),
                                )
                            : controller.isLoadingMlbGames.value
                            ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: Get.width,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            )
                            : controller.mlbGames.isEmpty
                            ? const Center(
                              child: Text(
                                'No MLB games available',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                            : MatchCard(
                              team1Name: controller.mlbGames[0]['team1Name'],
                              team1LogoPath:
                                  controller.mlbGames[0]['team1Image'],
                              team2Name: controller.mlbGames[0]['team2Name'],
                              team2LogoPath:
                                  controller.mlbGames[0]['team2Image'],
                              matchDateTime: _parseMatchTime(
                                controller.mlbGames[0]['matchTime'],
                              ),
                            ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final isNfl = controller.selectedLeague.value == 'NFL';
                    final games =
                        isNfl ? controller.nflGames : controller.mlbGames;
                    final isLoading =
                        isNfl
                            ? controller.isLoadingNflGames.value
                            : controller.isLoadingMlbGames.value;
                    return Container(
                      height: 70,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/predictions-bg.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isLoading || games.isEmpty
                                ? '--'
                                : '${games[0]['team1Percentage'].toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Winning Prediction',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            isLoading || games.isEmpty
                                ? '--'
                                : '${games[0]['team2Percentage'].toStringAsFixed(0)}%',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 25),
                  const Center(
                    child: Text(
                      'Table Stats',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => FutureBuilder<List<TableModel>>(
                      future: tableService.fetchTableData(
                        controller.selectedLeague.value,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF2F2F2F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: Column(
                              children: List.generate(
                                10,
                                (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6.0,
                                  ),
                                  child: Row(
                                    children: [
                                      // Team shimmer
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[700],
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // W:L shimmer
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[700],
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Avg PTS shimmer
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[700],
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Prediction shimmer
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[700],
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'No data available',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final tableData = snapshot.data!;
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF2F2F2F),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Team',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'W : L',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Avg PTS',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      flex: 1,
                                      child: Text(
                                        'Prediction',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ...tableData
                                  .map(
                                    (data) => TableRowWidget(
                                      team: data.teamName,
                                      win: data.winCount.toString(),
                                      loss: data.lossCount.toString(),
                                      avgPts: data.averageScore.toStringAsFixed(
                                        1,
                                      ),
                                      prediction:
                                          '${(data.winPercentage * 100).toStringAsFixed(1)}%',
                                    ),
                                  )
                                  // ignore: unnecessary_to_list_in_spreads
                                  .toList(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  String _parseMatchTime(String matchTime) {
    try {
      if (matchTime.isEmpty || matchTime == 'Unknown') {
        return '01/08/2025 12:30 AM';
      }
      final inputFormat = DateFormat('MM/dd\nh:mm a');
      final dateTime = inputFormat.parse(matchTime);
      final outputFormat = DateFormat('MM/dd\nh:mm a');
      return outputFormat.format(dateTime);
    } catch (e) {
      developer.log('Error parsing match time: $matchTime, error: $e' as num);
      return '01/08/2025 12:30 AM';
    }
  }
}
