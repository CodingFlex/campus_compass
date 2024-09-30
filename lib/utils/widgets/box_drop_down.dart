import 'package:campus_compass/ui/contribute/contribute_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:campus_compass/utils/shared/text_styles.dart';

import '../shared/app_colors.dart';

class BoxDropDown extends StatefulWidget {
  final ContributeViewModel model;
  const BoxDropDown({
    super.key,
    required this.model,
  });

  @override
  State<BoxDropDown> createState() => _BoxDropDownState();
}

class _BoxDropDownState extends State<BoxDropDown> {
  String? _dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: kcVeryLightGreyColor,
        border: Border.all(
          color: kcVeryLightGreyColor, // Set border color
          width: 1.0, // Set border width
        ),
        borderRadius:
            BorderRadius.all(Radius.circular(5.0) // Set rounded corner radius
                ),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton(
            hint: _dropDownValue == null
                ? Text('Place Type')
                : Text(
                    _dropDownValue!,
                    style: TextStyle(color: kcPrimaryColor),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(color: kcPrimaryColor),
            items: [
              'School Building',
              'Restaurant and Eatery',
              'Lecture Theatre',
              'Lab',
              'Other'
            ].map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(
                    val,
                    style: bodyStyle,
                  ),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(() {
                _dropDownValue = val;
                widget.model.placeType = val;
                widget.model.notifyListeners();
              });
            },
          ),
        ),
      ),
    );
  }
}
