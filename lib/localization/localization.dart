import 'package:get/get_navigation/src/root/internacionalization.dart';

class Localization extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        //English language
        'en_US': {
          // SideBar
          "sidebar_create_task": "Create task",
          "sidebar_result_detection": "Result of detection",
          "sidebar_task_list": "Task list",
          "sidebar_map": "Map",
          "sidebar_report": "Report",
          "sidebar_log_out": "Logout",

          //  User
          "is_admin": "administrator",
          "is_creator": "curator",
          "is_executor": "executor",

          //Tasks
          "completed_tasks": "completed tasks",
          "current_tasks": "current tasks",
          "expired_tasks": "expired tasks",

          "create_single_task": "Create single task",
          "run_detection": "Run detection",

          //Run detection
          "select_date_time": "Select DateTime",
          "select_video": "Upload video",
          "video_description": "supported files mp4, mpeg",
          "upload": "Upload",
        },
        //Russian language
        'ru_RU': {
          // SideBar
          "sidebar_create_task": "Создать задачу",
          "sidebar_result_detection": "Результат детектирования",
          "sidebar_task_list": "Список задач",
          "sidebar_map": "Карта",
          "sidebar_report": "Отчет",
          "sidebar_log_out": "Выйти",

          //  User
          "is_admin": "администратор",
          "is_creator": "куратор",
          "is_executor": "исполнитель",

          //Tasks
          "completed_tasks": "Выполнение задачи",
          "current_tasks": "Текущие задачи",
          "expired_tasks": "Просроченные задачи",

          "create_single_task": "Создать задачу",
          "run_detection": "Запуск на детектирование",

          //Run detection
          "select_date_time": "Выберите дату и время",
          "select_video": "Выберите видео файл",
          "video_description": "поддерживаемы файлы mp4, mpeg",
          "upload": "Отправить",
        }
      };
}
