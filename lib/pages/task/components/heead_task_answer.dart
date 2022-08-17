
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/task/controller/task_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

class HeadTaskAnswer extends GetView<TaskController> {
  const HeadTaskAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('Ответы',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            )),
        const Spacer(),
        if(controller.loginController.user?.isSuperUser!=true)
        ElevatedButton.icon(
          icon: Icon(
            controller.loginController.user?.isExecutor == true ? Icons.add : Icons.close,
            size: 16,
          ),
          onPressed: answerCallback,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          label: controller.loginController.user?.isExecutor == true ?const Text("добавить"):const Text("закрыть"),
        ),
      ],
    );
  }

  void answerCallback(){
    if(controller.loginController.user?.isExecutor == true){
      Get.bottomSheet(const _AddAnswer(), isScrollControlled: true);
    }else{
      Get.dialog(const _CloseTask());
    }
  }

}

class _AddAnswer extends StatelessWidget {
  const _AddAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: context.height/2,
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close))
            ],
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
              child: const TextField(decoration: InputDecoration(labelText: "описание"),)
          ),
          const SizedBox(height: UiConstants.defaultPadding,),
          _SelectFile(),
        ],
      ),
    );
  }
}

class _SelectFile extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(
      builder: (controller) => ElevatedButton(
          onPressed: ()=>controller.selectFile(),
          child:  Padding(
            padding: const EdgeInsets.all(UiConstants.defaultPadding),
            child: Text(
                controller.file!=null?
                    controller.file!.first.name:
                'Выберите изображение'
            ),
          ),
      ),
    );
  }


}

class _CloseTask extends StatelessWidget {
  const _CloseTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      // content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: ()=>Get.back(),
          // onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: (){},
          // onPressed: closeTask,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
