import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:flutter/material.dart';

import '../shared/app_colors.dart';

class BoxInputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final double? height;
  final double? width;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final void Function()? trailingTapped;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxInputField({
    Key? key,
    required this.controller,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      /// Overriding the default blue color.
      ///
      /// We can also avoid this by changing the [primarySwatch] in MaterialApp
      data: ThemeData(primaryColor: kcPrimaryColor),
      child: Container(
        height: height,
        width: width,
        child: TextField(
          controller: controller,
          style: bodyStyle,
          obscureText: password,
          decoration: InputDecoration(
            hintText: placeholder,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            filled: true,
            fillColor: kcVeryLightGreyColor,
            prefixIcon: leading,
            suffixIcon: trailing != null
                ? GestureDetector(
                    onTap: trailingTapped,
                    child: trailing,
                  )
                : null,
            border: circularBorder.copyWith(
              borderSide: BorderSide(color: kcLightGreyColor),
            ),
            errorBorder: circularBorder.copyWith(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedBorder: circularBorder.copyWith(
              borderSide: BorderSide(color: kcPrimaryColor),
            ),
            enabledBorder: circularBorder.copyWith(
              borderSide: BorderSide(color: kcLightGreyColor),
            ),
          ),
        ),
      ),
    );
  }
}
