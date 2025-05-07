import 'package:get/get.dart';

class ProfileInfoController extends GetxController {
  final userNameStatic = 'henry88';
  final fullName = 'Courtney Henry';

  var name = 'Courtney Henry'.obs;
  var username = 'henry88'.obs;
  var email = 'abcdefg@gmail.com'.obs;
  var phoneNumber = '12345678900'.obs;
  var country = 'USA'.obs;

  var isEditing = ''.obs;

  void startEditing(String field) => isEditing.value = field;

  void stopEditing() => isEditing.value = '';

  void updateValue(String field, String value) {
    switch (field) {
      case 'Name':
        name.value = value;
        break;
      case 'User Name':
        username.value = value;
        break;
      case 'Email':
        email.value = value;
        break;
      case 'Phone Number':
        phoneNumber.value = value;
        break;
      case 'Country':
        country.value = value;
        break;
    }
    stopEditing();
  }
}
