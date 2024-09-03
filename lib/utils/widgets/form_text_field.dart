import 'dart:async';

import 'package:campus_compass/utils/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../shared/text_styles.dart';

class CustomisedTextFormField extends StatefulWidget {
  // final String label;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool showSuffixIcon;
  final Widget? leading;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;

  //final ValueChanged<String>? onFieldSubmitted;

  CustomisedTextFormField({
    Key? key,
    // required this.label,
    required this.hintText,
    this.validator,
    this.controller,
    this.leading,
    this.showSuffixIcon = false,
    this.onEditingComplete,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomisedTextFormField> createState() =>
      _CustomisedTextFormFieldState();
}

class _CustomisedTextFormFieldState extends State<CustomisedTextFormField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  StreamController<AutovalidateMode> autoValidateMode =
      StreamController<AutovalidateMode>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AutovalidateMode>(
        stream: autoValidateMode.stream,
        builder: (context, snapshot) {
          return TextFormField(
            validator: widget.validator,
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            cursorColor: kcPrimaryColor,
            style: bodyStyle.copyWith(
              fontSize: 15,
            ),
            keyboardType: widget.keyboardType,
            obscureText:
                widget.showSuffixIcon ? _obscureText : _obscureText = false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // snapshot.data,
            onSaved: (_) {
              autoValidateMode.add(AutovalidateMode.onUserInteraction);
            },
            onEditingComplete: widget.onEditingComplete,
            decoration: InputDecoration(
              filled: true,
              fillColor: kcVeryLightGreyColor,
              contentPadding: EdgeInsets.only(left: 8),
              prefixIcon: widget.leading,
              suffixIcon: widget.showSuffixIcon
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _toggle();
                        });
                      },
                      icon: Icon(_obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
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
              hintText: widget.hintText,
              hintStyle: TextStyle(fontSize: 15.sp),
            ),
          );
        });
  }
}
