import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/api_service/head_to_head_service.dart';
import 'package:jsulima/features/game_details/model/head_to_head_model.dart';

class GameDetailsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  Rx<TabController?> tabController = Rx<TabController?>(null);

  // Head-to-head state
  final Rx<HeadToHeadModel?> headToHead = Rx<HeadToHeadModel?>(null);
  final RxBool isHeadToHeadLoading = false.obs;
  final RxString headToHeadError = ''.obs;

  void initializeTabController(TickerProvider vsync) {
    if (tabController.value == null) {
      tabController.value = TabController(length: 4, vsync: vsync);

      // Listen to changes in selectedIndex and update tabController
      selectedIndex.listen((index) {
        if (tabController.value?.index != index) {
          tabController.value?.animateTo(index);
        }
      });
    }
  }

  void disposeTabController() {
    tabController.value?.dispose();
    tabController.value = null;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchHeadToHead({
    required String homeTeam,
    required String awayTeam,
  }) async {
    isHeadToHeadLoading.value = true;
    headToHeadError.value = '';
    try {
      final result = await HeadToHeadService().getHeadToHead(
        homeTeam: homeTeam,
        awayTeam: awayTeam,
      );
      headToHead.value = result;
    } catch (e) {
      headToHeadError.value = e.toString();
    } finally {
      isHeadToHeadLoading.value = false;
    }
  }
}
