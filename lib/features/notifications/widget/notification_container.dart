import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/notifications/controller/notification_controller.dart';
import 'package:jsulima/features/notifications/widget/notification_item.dart';

class NotificationContainer extends StatelessWidget {
  NotificationContainer({super.key});

  final NotificationController buttonController = Get.put(
    NotificationController(),
  );

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notificationList = [
      //Notification 1
      {
        'title': "Prediction Update: Kansas City Chiefs vs. Buffalo Bills",
        'subTitle':
            "The game between Kansas City Chiefs and Buffalo Bills has updated predictions. Chiefs now have a 70% chance of winning. Check the new predictions!",
        'time': "2 mins ago",
      },
      //Notification 2
      {
        'title': " Injury Update: Patrick Mahomes",
        'subTitle':
            "Patrick Mahomes has been listed as questionable for today’s game against the Buffalo Bills due to an ankle injury. Stay tuned for further updates.",
        'time': "4 mins ago",
      },
      //Notification 3
      {
        'title':
            "Upcoming Game Reminder: New England Patriots vs. Miami Dolphins",
        'subTitle':
            "The New England Patriots will face off against the Miami Dolphins at 3:00 PM today! View your predictions and check out the key player stats.",
        'time': "5 mins ago",
      },
      //Notification 4
      {
        'title': "New Predictions for NFL Week 5",
        'subTitle':
            "Predictions for all NFL Week 5 games are now live! Check the updated stats and predictions for your favorite teams.",
        'time': "8 mins ago",
      },
      //Notification 5
      {
        'title': "Don’t Miss Out on Live Predictions!",
        'subTitle':
            "Live predictions for today’s NFL games are now available. Keep track of your favorite matchups and players with real-time updates.",
        'time': "10 mins ago",
      },
    ];
    return Container(
      margin: EdgeInsets.only(top: 45.0, left: 16.0, right: 16.0),
      height: double.infinity,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Notifications",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: 32,
            ),
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
                    width: 50,
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
                    child: Center(
                      child: Text(
                        'All',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF333333),
                        ),
                      ),
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
                    width: 100,
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
                  buttonController.onButtonClick(2);
                },
                child: Obx(() {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          buttonController.selectedButton.value == 2
                              ? Color(0xFFFFFFFF)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          buttonController.selectedButton.value == 2
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
          SizedBox(height: 20.0),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notificationList.length,

              itemBuilder: (context, index) {
                var notification = notificationList[index];
                return NotificationItem(
                  title: notification['title']!,
                  subTitle: notification['subTitle']!,
                  time: notification['time']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
