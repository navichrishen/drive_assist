import 'package:flutter/material.dart';

class CustomBreakdownTypeListTile extends StatelessWidget {
  final IconData? trailingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color tileColor;
  final Color textColor;
  final Color iconColor;
  final double borderRadius;

  // Default image path
  static const String _defaultImagePath = 'assets/images/breakdownIcon.png';

  const CustomBreakdownTypeListTile({
    Key? key,
    this.trailingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.tileColor = const Color.fromARGB(62, 158, 158, 158),
    this.textColor = Colors.black,
    this.iconColor = const Color.fromARGB(255, 19, 53, 123),
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: ListTile(
        leading: Image.asset(
          _defaultImagePath,
          color: iconColor,
          width: 45,
          height: 45,
        ),
        trailing: Icon(
          trailingIcon,
          color: textColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: TextStyle(
                  color: textColor,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
