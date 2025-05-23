import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';
import 'package:visita/constants/custom_appbar.dart';
import 'package:visita/constants/home_grids.dart';
import 'package:visita/constants/recents.dart';
import 'package:visita/controllers/api_controller.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/utils/text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ApiController apiController = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    final recent = apiController.data;
    print(recent['visits']);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50), 
        child: CustomAppbar(title: "Visita")
      ) ,     
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Dashboard", 
                      fontSize: 20, 
                      textColor: CustomColors.blak,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: "Welcome back!!", 
                      fontSize: 15, 
                      textColor: CustomColors.blak,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Get.toNamed("/add");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: CustomColors.primaryLight,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: "Add Visit", 
                        fontSize: 15,
                        fontWeight: FontWeight.bold, 
                        textColor: CustomColors.secondary
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(
            ()=>HomeGrids(
            title: "All visits", 
            icon: Icons.menu, 
            bg: CustomColors.primaryLight,
            ikon: Colors.white,
            total: apiController.allvisits.value.toString()
           ),
          ),
          Obx(
            ()=>HomeGrids(
            title: "Complited", 
            icon: Icons.receipt, 
            bg: Colors.green,
            ikon: Colors.white,
            total: apiController.completedCount.value.toString()
           ),
          ),
          Obx(
            ()=>HomeGrids(
            title: "Cancelled", 
            icon: Icons.cancel, 
            bg: Colors.redAccent,
            ikon: Colors.white,
            total: apiController.cancelledCount.value.toString()
           ),
          ),
          Obx(
            ()=>HomeGrids(
            title: "Pending", 
            icon: Icons.timelapse_rounded, 
            bg: Colors.deepPurple,
            ikon: Colors.white,
            total: apiController.pendingCount.value.toString()
           ),
          ),
          Obx(
            ()=>HomeGrids(
            title: "Succes rate", 
            icon: Icons.timeline, 
            bg: CustomColors.primaryLight,
            ikon: Colors.white,
            total: "${apiController.successRate.value.toStringAsFixed(1)}%"
           ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CustomText(
              text: "Recent visits", 
              fontSize: 18, 
              textColor: CustomColors.blak,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Obx(()=>apiController.isloading.value == false ? Column(
            children: List.generate(
              3,
              (index) => Recents(
                name: "${recent['customers'][index]['name']}",
                status: "${recent['visits']?[index]['status']}",
                time: "${apiController.formatVisitDate("${recent['visits']?[index]['created_at']}")}- ${apiController.formatVisitTime("${recent['visits']?[index]['created_at']}")}",
              ),
             ),      
            ) : Center(
            child: CircularProgressIndicator(),
           )
          )      
        ],
      ),
    );
  }
}