import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:visita/constants/custom_appbar.dart';
import 'package:visita/constants/visit_card.dart';
import 'package:visita/controllers/api_controller.dart';

class Visits extends StatelessWidget {
  Visits({super.key});
  final controller = Get.find<ApiController>();

  @override
  Widget build(BuildContext context) {
    final visists = controller.data["visits"];
    final customer = controller.data["customers"];
    return Scaffold(
     appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50), 
        child: CustomAppbar(title: "Visits")
      ) , 
      body: ListView(
        children: [
          ...List.generate(
           controller.data["customers"].length, 
            (index)=> VisitCard(
              customerName: customer[index]['name'], 
              status: visists[index]['status'], 
              date: controller.formatVisitDate("${visists[index]['created_at']}"), 
              time: controller.formatVisitTime("${visists[index]['created_at']}"), 
              location: "${visists[index]['location']}", 
              activities: ["${visists[index]["activities_done"]}"], 
              notes: "${visists[index]['notes']}"
            )
          )
        ],
      ),
    );
  }
}