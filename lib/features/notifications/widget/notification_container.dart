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
                    width: 60,
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
            child: Obx(() {
              if (buttonController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (buttonController.notifications.isEmpty) {
                return Center(
                  child: Text(
                    "No notifications found",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: buttonController.notifications.length,
                itemBuilder: (context, index) {
                  var notification = buttonController.notifications[index];
                  return NotificationItem(
                    title: notification['title'] ?? "",
                    subTitle: notification['message'] ?? "",
                    time: notification['createdAt'] ?? "",
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
