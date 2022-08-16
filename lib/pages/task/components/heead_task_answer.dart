
import 'package:flutter/material.dart';

class HeadTaskAnswer extends StatelessWidget {
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
        ElevatedButton.icon(
          icon: const Icon(
            Icons.add,
            size: 16,
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          label: const Text("добавить"),
        ),
      ],
    );
  }
}
