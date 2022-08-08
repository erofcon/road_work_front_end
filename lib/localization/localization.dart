import 'package:get/get_navigation/src/root/internacionalization.dart';

class Localization extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //English language
        'en_US': {
          "sidebar_title":"menu",
          "sidebar_info": "info",
          "sidebar_create_task":"Create task",
          "sidebar_result_detection": "Result of detection",
          "sidebar_task_list": "Task list",
          "sidebar_menu_map": "Map",
          "sidebar_menu_report": "Report",
        },
        //Russian language
        'ru_RU': {
          "sidebar_title":"меню",
          "sidebar_info": "Инфо",
          "sidebar_create_task":"Создать задачу",
          "sidebar_result_detection": "Результат детектирования",
          "sidebar_task_list": "Список задач",
          "sidebar_menu_map": "Карта",
          "sidebar_menu_report": "Отчет",
        }
      };
}
