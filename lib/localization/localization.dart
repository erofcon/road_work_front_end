import 'package:get/get_navigation/src/root/internacionalization.dart';

class Localization extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //English language
        'en_US': {'create_task': 'Create task'},
        //Russian language
        'ru_RU': {'create_task': 'Создать задачу'}
      };
}
