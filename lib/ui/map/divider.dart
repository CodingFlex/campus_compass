import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.0,
      color: Color.fromARGB(255, 213, 187, 236),
      thickness: 2.5,
    );
  }
}
