import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:road_work_front_end/utils/constants.dart';

class RecentTaskList extends StatelessWidget {
  const RecentTaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: context.height / 2),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        itemCount: 20,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: UiConstants.defaultPadding),
          child: RecentTask(),
        ),
      ),
    );
  }
}

class RecentTask extends StatelessWidget {
  const RecentTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiConstants.defaultPadding),
      ),
      leading: _buildIcon(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(),
      trailing: _trailingIcon(),
    );
  }

  Widget _buildTitle() {
    return Text(
      DateFormat('d MMM').format(DateTime.now()).toLowerCase(),
      style: const TextStyle(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      'ямочный ремонт',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildIcon() {
    return const CircleAvatar(
      backgroundImage: NetworkImage(
          'https://i.pinimg.com/originals/e9/e0/75/e9e075386271a5449e62e885cd8fa226.jpg'),
    );
  }

  Widget _trailingIcon() {
    return const CircleAvatar(
      backgroundColor: Colors.orange,
    );
  }
}
