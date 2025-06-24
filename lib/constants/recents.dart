import 'package:flutter/material.dart';
import 'package:visita/constants/helpers/visit_page_helpers.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/utils/text.dart';

class Recents extends StatelessWidget {
  final String name;
  final String status;
  final String time;
  const Recents({super.key,required this.name,  required this.status, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: CustomColors.primaryLight,
                child: Icon(
                  Icons.people_alt_outlined,
                  color: CustomColors.secondary,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name, 
                    fontSize: 16, 
                    textColor: CustomColors.blak,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: time, 
                    fontSize: 13, 
                    textColor: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),     
              Spacer(),             
              StatusBadge(status: status)
            ],
          ),
        ),
        ),
    );
  }
}