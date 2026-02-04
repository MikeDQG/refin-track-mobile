// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData? icon;
  final ThemeData theme;
  final double height;
  final double width;
  final double borderRadius;
  final double sizeFactor;
  final bool vertical;

  const CardButton({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    required this.theme,
    required this.height,
    this.width = double.infinity,
    this.borderRadius = 16.0,
    this.sizeFactor = 1.0,
    this.vertical = true,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: this.width,
      height: this.height,
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.borderRadius),
        ),
        clipBehavior: Clip.antiAlias, // needed for InkWell ripple
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: vertical ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon, color: Colors.white, size: this.sizeFactor * 50),
                Text(title, style: TextStyle(color: Colors.white, fontSize: 30 * this.sizeFactor)),
              ],
            ) : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...{
                  Icon(icon, color: Colors.white, size: this.sizeFactor * 50),
                  SizedBox(width: 8)},
                Text(title, style: TextStyle(color: Colors.white, fontSize: 30 * this.sizeFactor)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
