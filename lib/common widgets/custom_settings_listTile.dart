import 'package:flutter/material.dart';

class CustomSettingsListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color tileColor;
  final Color textColor;
  final Color iconColor;
  final double borderRadius;

  const CustomSettingsListTile({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.tileColor = Colors.white,
    this.textColor = Colors.black,
    this.iconColor = const Color.fromARGB(255, 19, 53, 123),
    this.borderRadius = 22.0,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: iconColor,
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
