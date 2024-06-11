import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    required this.textColor,
    required this.badgeColor,
    super.key
  });

  final String status;
  final Color textColor;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: badgeColor,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100)
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
          fontSize: 14
        ),
      ),
    );
  }
}
