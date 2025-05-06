import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/splashImage.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar with interactive search
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search ...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.grey[850],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.search, color: Colors.redAccent),
                          onPressed: () {
                            // Add search logic here
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Centered Toggle Buttons
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLeagueButton('NFL', 'assets/icons/nlf.png'),
                        SizedBox(width: 10),
                        _buildLeagueButton('MLB', 'assets/icons/mlb.png'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Match Info Card
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/images/container_bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/falcon.png',
                                  height: 70,
                                ), // Use actual team logo
                                SizedBox(height: 8),
                                Text(
                                  'Atlanta\nFalcon',
                                  // Removed invalid parameter
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'VS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '14 Feb\n3:00 PM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/icons/panther.png',
                                  height: 70,
                                ), // Use actual team logo
                                SizedBox(height: 8),
                                Text(
                                  'Carolina\nPanther',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Prediction Bar
                  Obx(() {
                    int left = controller.winningPrediction.value;
                    int right = 100 - left;
                    return Container(
                      height: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/predictions-bg.png',
                          ), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$left%',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Winning Prediction',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '$right%',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  Text(
                    'Top Predictions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Player Card
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF2F2F2F),
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
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
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
                        SizedBox(height: 16),
                        Text(
                          'Predicted Stats',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildStatBox('310', 'Passing Yards'),
                            _buildStatBox('2', 'Touchdowns'),
                            _buildStatBox('1', 'Interceptions'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              'AI Confidence',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Obx(() {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${controller.aiConfidence.value}%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Text(
                      'Table Stats',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2F2F2F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Header Row
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
                              SizedBox(width: 10),
                              Expanded(
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
                              SizedBox(width: 10),
                              Expanded(
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
                              SizedBox(width: 10),
                              Expanded(
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
                        // Divider(color: Colors.grey[700], thickness: 1),
                        // Data Rows
                        _buildTableRow(
                          'New England\nPatriots',
                          '12 : 4',
                          '28.2',
                          '65%',
                        ),
                        _buildTableRow(
                          'Buffalo\nBills',
                          '12 : 4',
                          '27.5',
                          '35%',
                        ),
                        _buildTableRow(
                          'Kansas City\nChiefs',
                          '12 : 4',
                          '31.5',
                          '55%',
                        ),
                        _buildTableRow(
                          'Los Angeles\nChargers',
                          '12 : 4',
                          '24.8',
                          '45%',
                        ),
                        _buildTableRow(
                          'Dallas\nCowboys',
                          '12 : 4',
                          '30.0',
                          '58%',
                        ),
                        _buildTableRow(
                          'Philadelphia\nEagles',
                          '12 : 4',
                          '26.2',
                          '42%',
                        ),
                        _buildTableRow(
                          'Green Bay\nPackers',
                          '12 : 4',
                          '26.2',
                          '42%',
                        ),
                        _buildTableRow(
                          'Minnesota\nVikings',
                          '12 : 4',
                          '26.2',
                          '42%',
                        ),
                        _buildTableRow(
                          'Miami\nDolphins',
                          '12 : 4',
                          '26.2',
                          '42%',
                        ),
                        _buildTableRow(
                          'Baltimore\nRavens',
                          '12 : 4',
                          '26.2',
                          '42%',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeagueButton(String league, String iconPath) {
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

  Widget _buildStatBox(String value, String label) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Container(
        width: 100,
        height: 80,
        decoration: BoxDecoration(
          color: Color(0xFFF6F0E8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF5A3E2B), fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTableRow(
  String team,
  String record,
  String avgPts,
  String prediction,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            team,
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Text(
            record,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Text(
            avgPts,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: Text(
            prediction,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
