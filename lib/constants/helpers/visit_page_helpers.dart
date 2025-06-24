
import 'package:flutter/material.dart';
import 'package:visita/utils/colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final bool? isSelected;
  const StatusBadge({super.key, required this.status, this.isSelected});
  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = Color(0xFFDCFCE7);
        textColor = Color(0xFF15803D);
        borderColor = Color(0xFFBBF7D0);
        icon = Icons.check_circle;
        break;
      case 'pending':
        backgroundColor = CustomColors.warningBackground;
        textColor = CustomColors.warningText;
        borderColor = CustomColors.warningBorder;
        icon = Icons.access_time;
        break;
      case 'cancelled':
        backgroundColor = Color(0xFFFEE2E2);
        textColor = Color(0xFFB91C1C);
        borderColor = Color(0xFFFECACA);
        icon = Icons.cancel;
        break;
      default:
        backgroundColor = Color(0xFFF3F4F6);
        textColor = CustomColors.textTertiary;
        borderColor = CustomColors.borderPrimary;
        icon = Icons.help;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: textColor,
          ),
          SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityChip extends StatelessWidget {
 final String activity;
  const ActivityChip({super.key, required this.activity});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CustomColors.primaryBackground,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        activity,
        style: TextStyle(
          fontSize: 12,
          color: CustomColors.primaryText,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}