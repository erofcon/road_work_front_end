import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/login/controller/login_controller.dart';
import 'package:road_work_front_end/theme/colors.dart';
import 'package:road_work_front_end/utils/constants.dart';

class UserProfile extends GetView<LoginController> {
  const UserProfile({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiConstants.defaultPadding),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(UiConstants.defaultPadding),
          child: Row(
            children: [
              const _BuildImage(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _BuildName(),
                    _buildJob(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildJob() {
    return Text(
      (() {
        if (controller.user?.isSuperUser ?? false) {
          return 'is_admin'.tr;
        } else if (controller.user?.isCreator ?? false) {
          return 'is_creator'.tr;
        } else if (controller.user?.isExecutor ?? false) {
          return 'is_executor'.tr;
        }
        return '';
      })(),
      style: TextStyle(
        fontWeight: FontWeight.w300,
        color: CustomColors.iconColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _BuildName extends GetView<LoginController> {
  const _BuildName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '${controller.user?.firstName} ${controller.user?.lastName}',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _BuildImage extends GetView<LoginController> {
  const _BuildImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: CustomColors.avatarColor,
      child: Text(
        (() {
          if (controller.user!.firstName != '' &&
              controller.user!.lastName != '') {
            return controller.user!.firstName![0].toUpperCase() +
                controller.user!.lastName![0].toUpperCase();
          }
          return '';
        })(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
