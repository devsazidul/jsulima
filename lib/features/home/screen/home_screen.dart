import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/home/widgets/league_button_widget.dart';
import 'package:jsulima/features/home/widgets/match_card.dart';
import 'package:jsulima/features/home/widgets/stat_box_widget.dart';
import 'package:jsulima/features/home/widgets/table_row_widget.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());

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
    body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashImage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile.png'),
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
                    icon: const Icon(Icons.search, color: Colors.redAccent),
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
                      ? MatchCard(
                        team1Name: 'Atlanta\nFalcon',
                        team1LogoPath: 'assets/icons/falcon.png',
                        team2Name: 'Carolina\nPanther',
                        team2LogoPath: 'assets/icons/panther.png',
                        matchDateTime: DateTime(2025, 2, 14, 15, 0),
                      )
                      : MatchCard(
                        team1Name: 'New York\nYankees',
                        team1LogoPath: 'assets/icons/newyork.png',
                        team2Name: 'Boston Red\nSox',
                        team2LogoPath: 'assets/icons/boston.png',
                        matchDateTime: DateTime(2025, 2, 14, 15, 0),
                      ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => Container(
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
                      '${controller.winningPrediction.value}%',
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
                      '${100 - controller.winningPrediction.value}%',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Top Predictions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF2F2F2F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/matt-ryan-1.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Matt Ryan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Quarterback',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Predicted Stats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StatBoxWidget(value: '310', label: 'Passing Yards'),
                        StatBoxWidget(value: '2', label: 'Touchdowns'),
                        StatBoxWidget(value: '1', label: 'Interceptions'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        'AI Confidence',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${controller.aiConfidence.value}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
            Container(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: const Text(
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
                        Expanded(
                          flex: 1,
                          child: const Text(
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
                        Expanded(
                          flex: 1,
                          child: const Text(
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
                        Expanded(
                          flex: 1,
                          child: const Text(
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
                  TableRowWidget(
                    team: 'New England\nPatriots',
                    record: '12 : 4',
                    avgPts: '28.2',
                    prediction: '65%',
                  ),
                  TableRowWidget(
                    team: 'Buffalo\nBills',
                    record: '12 : 4',
                    avgPts: '27.5',
                    prediction: '35%',
                  ),
                  TableRowWidget(
                    team: 'Kansas City\nChiefs',
                    record: '12 : 4',
                    avgPts: '31.5',
                    prediction: '55%',
                  ),
                  TableRowWidget(
                    team: 'Los Angeles\nChargers',
                    record: '12 : 4',
                    avgPts: '24.8',
                    prediction: '45%',
                  ),
                  TableRowWidget(
                    team: 'Dallas\nCowboys',
                    record: '12 : 4',
                    avgPts: '30.0',
                    prediction: '58%',
                  ),
                  TableRowWidget(
                    team: 'Philadelphia\nEagles',
                    record: '12 : 4',
                    avgPts: '26.2',
                    prediction: '42%',
                  ),
                  TableRowWidget(
                    team: 'Green Bay\nPackers',
                    record: '12 : 4',
                    avgPts: '26.2',
                    prediction: '42%',
                  ),
                  TableRowWidget(
                    team: 'Minnesota\nVikings',
                    record: '12 : 4',
                    avgPts: '26.2',
                    prediction: '42%',
                  ),
                  TableRowWidget(
                    team: 'Miami\nDolphins',
                    record: '12 : 4',
                    avgPts: '26.2',
                    prediction: '42%',
                  ),
                  TableRowWidget(
                    team: 'Baltimore\nRavens',
                    record: '12 : 4',
                    avgPts: '26.2',
                    prediction: '42%',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
