import 'package:get/get.dart';
import 'package:jsulima/core/services/profile_services.dart';
import 'package:jsulima/core/services/shared_preferences_helper.dart'
    show SharedPreferencesHelper;
import 'package:jsulima/features/welcome_screen/screen/welcome_screen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileInfoController extends GetxController {
  final ProfileServices profileServices = ProfileServices();

  var image = ''.obs;
  var name = ''.obs;
  var username = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var country = ''.obs;
  var isEditing = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // Fetch profile data
  Future<void> fetchProfile() async {
    try {
      final profile = await profileServices.getProfile();
      name.value = profile.name ?? '';
      username.value = profile.userName ?? '';
      phoneNumber.value = profile.phone ?? '';
      country.value = profile.country ?? '';
      image.value = profile.image ?? '';
      email.value = profile.email ?? '';
    } catch (e) {
      EasyLoading.showError('Failed to fetch profile data.');
    }
  }

  void startEditing(String field) => isEditing.value = field;

  void stopEditing() => isEditing.value = '';

  void updateValue(String field, String value) {
    Map<String, dynamic> updatedFields = {};
    switch (field) {
      case 'Name':
        name.value = value;
        updatedFields['fullName'] = value;
        break;
      case 'User Name':
        username.value = value;
        updatedFields['userName'] = value;
        break;
      case 'Email':
        email.value = value;
        updatedFields['email'] = value;
        break;
      case 'Phone Number':
        phoneNumber.value = value;
        updatedFields['phoneNumber'] = value;
        break;
      case 'Country':
        country.value = value;
        updatedFields['country'] = value;
        break;
    }
    stopEditing();
    profileServices.updateProfile(updatedFields);
  }

  void logout() {
    SharedPreferencesHelper.clearAllAppData();
    Get.offAll(() => WelcomeScreen());
  }
}
