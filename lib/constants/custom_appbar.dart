import 'package:flutter/material.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/utils/text.dart';

class CustomAppbar extends StatelessWidget {
 final  String title;
  const CustomAppbar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6)
          ),
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: CustomText(
        text: title, 
        fontSize: 18, 
        textColor: CustomColors.blak,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.settings,
              size: 19,
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.notifications,
              size: 19,
            ),
          ),
        ),
        GestureDetector(
          onTap: (){},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: CustomColors.primaryLight,
              child: Icon(
                Icons.person,
                color: CustomColors.secondary,
                size: 19,
              ),
            ),
          ),
        ),          
      ],
      elevation: 1,
    );
  }
}