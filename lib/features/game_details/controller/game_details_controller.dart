import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameDetailsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  Rx<TabController?> tabController = Rx<TabController?>(null);

  void initializeTabController(TickerProvider vsync) {
    tabController.value = TabController(length: 4, vsync: vsync);

    // Listen to changes in selectedIndex and update tabController
    selectedIndex.listen((index) {
      if (tabController.value?.index != index) {
        tabController.value?.animateTo(index);
      }
    });
  }

  void disposeTabController() {
    tabController.value?.dispose();
    tabController.value = null;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
