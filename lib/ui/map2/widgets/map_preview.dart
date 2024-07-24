// preview_widget.dart
import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:campus_compass/utils/shared/ui_helpers.dart';
import 'package:campus_compass/utils/widgets/box_text.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/shared/text_styles.dart';
import '../../../utils/widgets/box_input_field.dart';
import '../map_viewmodel.dart';

class PreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => MapViewModel(),
      builder: (context, model, child) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: kcLightGreyColor,
                  borderRadius:
                      BorderRadius.circular(12), // Adjust the radius as needed
                ),
              ),
            ),
            Text(
              'Hey, where would you like to go?',
              style: headlineStyle.copyWith(fontSize: 20),
            ),
            horizontalSpaceLarge,
            BoxInputField(
              controller: model.searchLocation,
              placeholder: 'Search Location',
              leading: Icon(
                Icons.search,
                color: Color.fromARGB(255, 166, 166, 166),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
