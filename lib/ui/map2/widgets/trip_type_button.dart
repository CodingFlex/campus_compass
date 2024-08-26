import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/shared/app_colors.dart';

class TripTypeButton extends StatelessWidget {
  final IconData icon;

  const TripTypeButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        height: 50,
        width: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 0.2, // Border width
          ),
          color: Colors.white, // Background color of the square
          borderRadius: BorderRadius.circular(5), // Curved edges
        ),
        padding: EdgeInsets.all(8), // Padding inside the square
        child: Icon(
          icon,
          color: kcPrimaryColor,
        ),
      ),
    );
  }
}
