import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'elevated_button_theme.dart';

class CustomGradientButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double width;
  final double height;
  final bool isDisabled;

  const CustomGradientButton({
  super.key,
  this.onPressed,
  required this.text,
  required this.width,
  required this.height,
  required this.isDisabled ,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(98, 205, 203, 1),
            Color.fromRGBO(69, 153, 219, 1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(

        onPressed: isDisabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: isDisabled
              ? WidgetStateProperty.resolveWith<Color>(
                (states) => YouAppColors.darkerGreyOpasited,
          )
              : WidgetStateProperty.resolveWith<Color>(
    (states) => Colors.transparent), // Use null to allow the gradient to show
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}