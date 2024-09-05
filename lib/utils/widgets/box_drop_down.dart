import 'package:flutter/material.dart';

import 'package:campus_compass/utils/shared/text_styles.dart';

import '../shared/app_colors.dart';

class BoxDropdownField extends StatelessWidget {
  final List<String> items;
  final String? selectedItem;
  final void Function(String?)? onChanged;
  final String placeholder;
  final double? height;
  final double? width;
  final Widget? leading;
  final Widget? trailing;

  BoxDropdownField({
    Key? key,
    required this.items,
    this.selectedItem,
    this.placeholder = '',
    this.height,
    this.width,
    this.leading,
    this.trailing,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if selectedItem is in the items list, otherwise set it to null
    final effectiveValue = items.contains(selectedItem) ? selectedItem : null;

    return Theme(
      data: ThemeData(primaryColor: kcPrimaryColor),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: kcVeryLightGreyColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: kcLightGreyColor,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: effectiveValue,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
            style: bodyStyle.copyWith(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
            hint: Text(
              placeholder,
              style: bodyStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
