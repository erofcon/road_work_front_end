import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task_list/controller/task_list_controller.dart';

import '../../routes/routes.dart';

class TaskListPage extends GetView<TaskListController> {
  const TaskListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return DataTable2(
              showCheckboxColumn: false,
              columnSpacing: 15,
              minWidth: 500,
              columns: const [
                DataColumn(label: Text('Дата')),
                DataColumn(label: Text('Состояние')),
                DataColumn(label: Text('Исполнитель')),
                DataColumn(label: Text('Куратор')),
              ],
              rows: controller.taskList.value.results.map((item) {
                return DataRow(
                    onSelectChanged: (_) {
                      Get.toNamed(RoutesClass.task, arguments: item.id);
                    },
                    cells: [
                      DataCell(Text(item.createDateTime??'')),
                      DataCell(Text((() {
                        if (item.isDone??false) {
                          return "выполнено";
                        } else if (item.isExpired??false) {
                          return "просрочено";
                        }
                        return "на исполнении";
                      })())),
                      DataCell(Text(
                          '${item.executor?.firstName??''} ${item.executor?.lastName??''}')),
                      DataCell(Text(
                          '${item.creator?.firstName??''} ${item.creator?.lastName??''}')),
                    ]);
              }).toList(),
            );
          }
        }),
      ),
    );
  }
}
