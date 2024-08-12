import 'package:campus_compass/ui/map2/map_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/widgets/box_input_field.dart';

class MapTextField extends StatelessWidget {
  final bool isDestination;
  final MapViewModel model;
  const MapTextField(
      {super.key, required this.isDestination, required this.model});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BoxInputField(
        controller:
            isDestination == true ? model.startLocation : model.destLocation,
        width: 350,
        height: 50,
        onChanged: (value) {
          model.onChangeHandler(value, isDestination);
        },
        placeholder: isDestination == true
            ? 'Enter a destination'
            : 'Enter a start location',
      ),
      // leading: const Icon(
      //   Icons.location_on_outlined,
      //   color: kcMediumGreyColor,
      //   size: 20,
      // ),
    );
  }
}
