import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());

  Widget _leagueButton(String league, String iconPath) => GestureDetector(
        onTap: () => controller.selectLeague(league),
        child: Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  color: controller.selectedLeague.value == league
                      ? Colors.white
                      : Colors.transparent,
                  border: Border.all(
                      color: controller.selectedLeague.value == league
                          ? Colors.white
                          : Colors.grey.shade700),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(children: [
                Text(league,
                    style: TextStyle(
                        color: controller.selectedLeague.value == league
                            ? Colors.black
                            : Colors.grey,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 6),
                Image.asset(iconPath, width: 40, height: 35)
              ]),
            )),
      );

  Widget _statBox(String value, String label) => Padding(
        padding: EdgeInsets.all(5),
        child: Container(
            width: 100,
            height: 80,
            decoration: BoxDecoration(
                color: Color(0xFFF6F0E8), borderRadius: BorderRadius.circular(12)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(value,
                  style: TextStyle(
                      color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF5A3E2B), fontSize: 13))
            ])),
      );

  Widget _tableRow(String team, String record, String avgPts, String prediction) =>
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                flex: 2,
                child: Text(team,
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left)),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: Text(record,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center)),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: Text(avgPts,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center)),
            SizedBox(width: 10),
            Expanded(
                flex: 1,
                child: Text(prediction,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center))
          ]));

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(children: [
          Positioned.fill(
              child: Image.asset('assets/images/splashImage.png', fit: BoxFit.cover)),
          SafeArea(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/profile.png')),
                      SizedBox(width: 10),
                      Expanded(
                          child: TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: 'Search ...',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: Colors.grey[850],
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none)))),
                      SizedBox(width: 10),
                      Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(10)),
                          child: IconButton(
                              icon: Icon(Icons.search, color: Colors.redAccent),
                              onPressed: () {}))
                    ]),
                    SizedBox(height: 20),
                    Center(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                      _leagueButton('NFL', 'assets/icons/nlf.png'),
                      SizedBox(width: 10),
                      _leagueButton('MLB', 'assets/icons/mlb.png')
                    ])),
                    SizedBox(height: 20),
                    Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: AssetImage('assets/images/container_bg.png'),
                                fit: BoxFit.cover)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(children: [
                                Image.asset('assets/icons/falcon.png', height: 70),
                                SizedBox(height: 8),
                                Text('Atlanta\nFalcon',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18))
                              ]),
                              Column(children: [
                                Text('VS',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Text('14 Feb\n3:00 PM',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))
                              ]),
                              Column(children: [
                                Image.asset('assets/icons/panther.png', height: 70),
                                SizedBox(height: 8),
                                Text('Carolina\nPanther',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))
                              ])
                            ])),
                    SizedBox(height: 10),
                    Obx(() => Container(
                        height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/predictions-bg.png'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${controller.winningPrediction.value}%',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              Text('Winning Prediction',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              Text('${100 - controller.winningPrediction.value}%',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold))
                            ]))),
                    SizedBox(height: 20),
                    Text('Top Predictions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xFF2F2F2F),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Image.asset('assets/images/matt-ryan-1.png',
                                    width: 60, height: 60, fit: BoxFit.cover),
                                SizedBox(width: 12),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Matt Ryan',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      Text('Quarterback',
                                          style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 15))
                                    ])
                              ]),
                              SizedBox(height: 16),
                              Text('Predicted Stats',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _statBox('310', 'Passing Yards'),
                                    _statBox('2', 'Touchdowns'),
                                    _statBox('1', 'Interceptions')
                                  ]),
                              SizedBox(height: 16),
                              Row(children: [
                                Text('AI Confidence',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                SizedBox(width: 10),
                                Obx(() => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.red, shape: BoxShape.circle),
                                    child: Text(
                                        '${controller.aiConfidence.value}%',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))))
                              ])
                            ])),
                    SizedBox(height: 25),
                    Center(
                        child: Text('Table Stats',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold))),
                    SizedBox(height: 20),
                    Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF2F2F2F),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text('Team',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        flex: 1,
                                        child: Text('W : L',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        flex: 1,
                                        child: Text('Avg PTS',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center)),
                                    SizedBox(width: 10),
                                    Expanded(
                                        flex: 1,
                                        child: Text('Prediction',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center))
                                  ])),
                          _tableRow('New England\nPatriots', '12 : 4', '28.2',
                              '65%'),
                          _tableRow('Buffalo\nBills', '12 : 4', '27.5', '35%'),
                          _tableRow('Kansas City\nChiefs', '12 : 4', '31.5',
                              '55%'),
                          _tableRow('Los Angeles\nChargers', '12 : 4', '24.8',
                              '45%'),
                          _tableRow('Dallas\nCowboys', '12 : 4', '30.0', '58%'),
                          _tableRow('Philadelphia\nEagles', '12 : 4', '26.2',
                              '42%'),
                          _tableRow('Green Bay\nPackers', '12 : 4', '26.2',
                              '42%'),
                          _tableRow('Minnesota\nVikings', '12 : 4', '26.2',
                              '42%'),
                          _tableRow('Miami\nDolphins', '12 : 4', '26.2', '42%'),
                          _tableRow('Baltimore\nRavens', '12 : 4', '26.2', '42%')
                        ])),
                    SizedBox(height: 40)
                  ])))
        ]),
      );
}