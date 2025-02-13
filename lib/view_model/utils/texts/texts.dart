import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTitle extends StatelessWidget {
  const TextTitle(
      this.text, {
        super.key,
        this.textAlign,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.overflow, this.shadows,
      });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final List<Shadow>? shadows;


  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 16.sp,
        color: color,
        fontFamily: 'Lamar',
          shadows: shadows

      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,

    );
  }
}

class TextBody14 extends StatelessWidget {
  const TextBody14(
      this.text, {
        super.key,
        this.textAlign,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.overflow, this.shadows,
      });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
final List<Shadow>? shadows;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 14.sp,
        color: color,
        fontFamily: 'Lamar',
        shadows: shadows
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
    );
  }
}

class TextBody12 extends StatelessWidget {
  const TextBody12(
      this.text, {
        super.key,
        this.textAlign,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.overflow,
      });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 12.sp,
        color: color,
        fontFamily: 'Lamar',

      ),
      maxLines: 1,
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,
    );
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription(
      this.text, {
        super.key,
        this.textAlign,
        this.fontSize,
        this.fontWeight,
        this.color,
        this.overflow,
      });

  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? 10.sp,
        color: color,
        fontFamily: 'Lamar',
      ),
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow,

    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        super.key,
        required this.gradient,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.overflow,
        this.strokeColor , // Default stroke color
        this.strokeWidth, this.shadows, // Default stroke width
      });

  final String text;
  final Gradient gradient;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final Color? strokeColor;
  final double? strokeWidth;
  final List<Shadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Stroke Layer
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: 'Lamar',
            foreground: strokeColor == null && strokeWidth == null ? null : Paint()
              ?..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth!
              ..color = strokeColor!, // Stroke color
            shadows: shadows
          ),
          textAlign: textAlign,
          overflow: overflow,
        ),
        // Gradient Fill Layer
        ShaderMask(
          shaderCallback: (bounds) {
            return gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: 'Lamar',
              color: Colors.white, // This color is ignored by ShaderMask
            ),
            textAlign: textAlign,
            overflow: overflow,
          ),
        ),
      ],
    );
  }
}
