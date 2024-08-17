import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/shared/app_colors.dart';

class TripTypeButton extends StatelessWidget {
  final IconData icon;

  const TripTypeButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 2, // Border width
          ),
          color: Colors.white, // Background color of the square
          borderRadius: BorderRadius.circular(8), // Curved edges
        ),
        padding: EdgeInsets.all(8), // Padding inside the square
        child: IconButton(
          iconSize: 25,
          onPressed: () {},
          icon: Icon(icon),
          color: kcMediumGreyColor,

          // Icon color
        ),
      ),
    );
  }
}
