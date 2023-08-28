import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color bgColor;
  final Color txtColor;

  const ReusableButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.bgColor,
    required this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 12,
          letterSpacing: 2,
          color: txtColor,
        ),
      ),
    );
  }
}
