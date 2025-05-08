import 'package:get/get.dart';

class GameDetailsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
