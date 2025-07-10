import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jsulima/features/game_details/api_service/field_lineup_service.dart';
import 'package:jsulima/features/game_details/model/field_lineup_model.dart';
import 'package:flutter/foundation.dart';

class FieldController extends GetxController {
  final RxString imageBase64 = ''.obs;
  final RxBool isLoading = false.obs;
  final RxList<FieldPlayer> homePlayers = <FieldPlayer>[].obs;
  final RxList<FieldPlayer> awayPlayers = <FieldPlayer>[].obs;

  Future<void> fetchLineupAndImage(String homeTeam, String awayTeam) async {
    if (kDebugMode) {
      print('FieldController: Starting fetchLineupAndImage');
      print('FieldController: homeTeam: $homeTeam, awayTeam: $awayTeam');
    }

    isLoading.value = true;
    try {
      if (kDebugMode) {
        print('FieldController: Calling FieldLineupService.getFieldLineup');
      }

      final fieldLineupResponse = await FieldLineupService().getFieldLineup(
        homeTeam,
        awayTeam,
      );

      if (kDebugMode) {
        print('FieldController: API call successful');
        print(
          'FieldController: lineupImage length: ${fieldLineupResponse.lineupImage.length}',
        );
        print(
          'FieldController: homePlayers count: ${fieldLineupResponse.homePlayers.length}',
        );
        print(
          'FieldController: awayPlayers count: ${fieldLineupResponse.awayPlayers.length}',
        );
      }

      // Update the image
      imageBase64.value = fieldLineupResponse.lineupImage;

      // Update the players lists
      homePlayers.value = fieldLineupResponse.homePlayers;
      awayPlayers.value = fieldLineupResponse.awayPlayers;

      if (kDebugMode) {
        print('FieldController: Data updated successfully');
        print(
          'FieldController: imageBase64.value length: ${imageBase64.value.length}',
        );
        print('FieldController: homePlayers length: ${homePlayers.length}');
        print('FieldController: awayPlayers length: ${awayPlayers.length}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('FieldController: Error in fetchLineupAndImage: $e');
      }
      EasyLoading.showError('Failed to fetch field lineup.');
    } finally {
      isLoading.value = false;
      if (kDebugMode) {
        print(
          'FieldController: fetchLineupAndImage completed, isLoading: ${isLoading.value}',
        );
      }
    }
  }

  // Helper methods to get players by unit group
  List<FieldPlayer> getHomeOffensePlayers() {
    return homePlayers
        .where((player) => player.unitGroup == 'offense')
        .toList();
  }

  List<FieldPlayer> getHomeDefensePlayers() {
    return homePlayers
        .where((player) => player.unitGroup == 'defense')
        .toList();
  }

  List<FieldPlayer> getAwayOffensePlayers() {
    return awayPlayers
        .where((player) => player.unitGroup == 'offense')
        .toList();
  }

  List<FieldPlayer> getAwayDefensePlayers() {
    return awayPlayers
        .where((player) => player.unitGroup == 'defense')
        .toList();
  }

  // Helper methods to get starters
  List<FieldPlayer> getHomeStarters() {
    return homePlayers
        .where((player) => player.starterPrediction == 1)
        .toList();
  }

  List<FieldPlayer> getAwayStarters() {
    return awayPlayers
        .where((player) => player.starterPrediction == 1)
        .toList();
  }
}
