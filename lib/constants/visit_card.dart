import 'package:flutter/material.dart';
import 'package:visita/constants/helpers/visit_page_helpers.dart';
import 'package:visita/utils/colors.dart';

class VisitCard extends StatelessWidget {
  final String customerName;
  final String status;
  final String date;
  final String time;
  final String location;
  final List<String> activities;
  final String notes;
  final VoidCallback? onTap;
  const VisitCard({
    super.key,
    required this.customerName,
    required this.status,
    required this.date,
    required this.time,
    required this.location,
    required this.activities,
    required this.notes,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: CustomColors.borderPrimary),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customerName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: CustomColors.textTertiary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.textTertiary,
                              ),
                            ),
                            SizedBox(width: 16),
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: CustomColors.textTertiary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(status: status),
                ],
              ),            
              SizedBox(height: 12),            
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: CustomColors.textTertiary,
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      location,
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomColors.textTertiary,
                      ),
                    ),
                  ),
                ],
              ),
              if (activities.isNotEmpty) ...[
                SizedBox(height: 12),
                Text(
                  'ACTIVITIES',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.textTertiary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: activities.map((activity) => ActivityChip(activity: activity)).toList(),
                ),
              ],
              if (notes.isNotEmpty) ...[
                SizedBox(height: 12),
                Text(
                  "notes: $notes",
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomColors.textTertiary,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}