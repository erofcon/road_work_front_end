import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_work_front_end/pages/dashboard/controller/dashboard_controller.dart';

class RelatedUsers extends GetView<DashboardController> {
  const RelatedUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        controller.relatedUser.length,
        (index) => SimpleUserProfile(
          firstName: controller.relatedUser[index].firstName,
          lastName: controller.relatedUser[index].lastName,
          onPressed: () {},
        ),
      ).toList(),
    );
  }
}

class SimpleUserProfile extends StatelessWidget {
  const SimpleUserProfile({
    required this.onPressed,
    required this.firstName,
    required this.lastName,
    Key? key,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        leading: _buildAvatar(),
        title: _buildName(),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.open_in_new),
          splashRadius: 24,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.orange.withOpacity(.2),
      child: Text(
        firstName[0].toUpperCase() + lastName[0].toUpperCase(),
        style: const TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      '$firstName $lastName',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
