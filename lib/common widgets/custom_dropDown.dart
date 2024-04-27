import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final IconData
      prefixIcon; // Added prefixIcon for consistency with CustomTextField
  final IconData suffixIcon;
  final Color iconColor; // Added iconColor for consistency with CustomTextField
  final Color
      borderColor; // Added borderColor for consistency with CustomTextField
  final double
      borderRadius; // Added borderRadius for consistency with CustomTextField

  const CustomDropdown({
    Key? key,
    required this.labelText,
    this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.prefixIcon =
        Icons.supervised_user_circle_outlined, // Default prefix icon
    this.suffixIcon = Icons.keyboard_arrow_down_rounded, // Default suffix icon
    this.iconColor = Colors.black, // Default icon color
    this.borderColor = Colors.grey, // Default border color
    this.borderRadius = 8.0, // Default border radius
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.value,
      onChanged: widget.onChanged,
      items: widget.items,
      icon: SizedBox.shrink(), // Removing the default dropdown icon
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: widget.iconColor,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(
          color: Colors.black, // Label color
        ),
        hintStyle: TextStyle(
          color: Colors.black, // Hint text color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        suffixIcon: Icon(
          widget.suffixIcon,
          color: widget.iconColor,
        ),
      ),
    );
  }
}
