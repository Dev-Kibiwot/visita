import 'package:flutter/material.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/utils/text.dart';

class HomeGrids extends StatelessWidget {
 final  String title;
 final  IconData icon;
 final  String total;
 final  Color bg;
 final  Color ikon;
 const HomeGrids({
    super.key,
    required this.title,
    required this.icon,
    required this.total,
    required this.bg,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: CustomColors.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [          
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: CustomColors.blak,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: total,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: CustomColors.blak,
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(6)
              ),
              child: Icon(
                icon,
                size: 26,
                color: ikon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
