import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Color iconColor;
  final Color borderColor;
  final double borderRadius;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  bool obscureText;

  CustomTextField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      this.iconColor = Colors.black, // Default icon color
      this.borderColor = Colors.grey, // Default border color
      this.borderRadius = 8.0, // Default border radius
      this.keyboardType = TextInputType.text,
      this.controller,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller, // Assigning the provided controller here
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: iconColor,
        ),
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: iconColor,
              )
            : null,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
