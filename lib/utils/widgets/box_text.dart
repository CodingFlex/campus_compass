// box_text.dart
import 'package:campus_compass/utils/shared/text_styles.dart';
import 'package:flutter/material.dart';
// Make sure to adjust the path as needed

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;

  BoxText.headingOne(this.text, {TextAlign align = TextAlign.start})
      : style = heading1Style,
        alignment = align;

  BoxText.headingTwo(this.text, {TextAlign align = TextAlign.start})
      : style = heading2Style,
        alignment = align;

  BoxText.headingThree(this.text, {TextAlign align = TextAlign.start})
      : style = heading3Style,
        alignment = align;

  BoxText.headline(this.text, {TextAlign align = TextAlign.center})
      : style = headlineStyle,
        alignment = align;

  BoxText.subheading(this.text, {TextAlign align = TextAlign.start})
      : style = subheadingStyle,
        alignment = align;

  BoxText.caption(this.text, {TextAlign align = TextAlign.start})
      : style = captionStyle,
        alignment = align;

  BoxText.body(this.text,
      {Color color = const Color(0xFF8A8A8A),
      TextAlign align = TextAlign.start})
      : style = bodyStyle.copyWith(color: color),
        alignment = align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}
