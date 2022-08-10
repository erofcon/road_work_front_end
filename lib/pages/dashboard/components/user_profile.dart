import 'package:flutter/material.dart';
import 'package:road_work_front_end/utils/constants.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    required this.userName,
    required this.job,
    required this.onPressed,
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  final String? imageUrl;
  final String userName;
  final String job;
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
                    _buildJobdesk(),
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
      backgroundImage: imageUrl!=null?NetworkImage(imageUrl!):null,
    );
  }

  Widget _buildName() {
    return Text(
      userName,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildJobdesk() {
    return Text(
      job,
      style: const TextStyle(
        fontWeight: FontWeight.w300,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
