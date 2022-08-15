import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/login/controller/login_controller.dart';
import 'package:road_work_front_end/utils/constants.dart';

class UserProfile extends GetView<LoginController> {
  const UserProfile({
    required this.onPressed,
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String? imageUrl;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UiConstants.defaultPadding),
      child: InkWell(
        borderRadius: BorderRadius.circular(UiConstants.defaultPadding),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(UiConstants.defaultPadding),
          child: Row(
            children: [
              _buildImage(),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildName(),
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

  Widget _buildImage() {
    return CircleAvatar(
      radius: 25,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
    );
  }

  Widget _buildName() {
    return Text(
      '${controller.user?.firstName} ${controller.user?.lastName}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
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
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
