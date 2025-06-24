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
  final ApiController apiController = Get.find<ApiController>();
  @override
  Widget build(BuildContext context) {
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
          Obx(() {
            if (apiController.isloading.value) {
              return Center(child: CircularProgressIndicator());
            }
            final visits = apiController.data['visits'] as List?;
            final customers = apiController.data['customers'] as List?;
            if (visits == null || customers == null || visits.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "No internet connection",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please check your connection and try again",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => apiController.getData(),
                      child: Text("Retry"),
                    ),
                  ],
                ),
              );
            }
            return Column(
              children: List.generate(
                3,
                (index) {
                  final visit = visits[index];
                  final customer = index < customers.length ? customers[index] : null;
                  return Recents(
                    name: customer?['name'] ?? 'Unknown Customer',
                    status: visit?['status'],
                    time: visit?['created_at'] != null 
                      ? "${apiController.formatVisitDate(visit['created_at'])} - ${apiController.formatVisitTime(visit['created_at'])}"
                      : 'Unknown Date',
                  );
                },
              ),
            );
           }
          )    
        ],
      ),
    );
  }
}