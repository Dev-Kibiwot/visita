import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visita/controllers/bottom_nav_controller.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/views/home_page.dart';
import 'package:visita/views/search_page.dart';
import 'package:visita/views/visits.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomePage(),
    Visits(),
    SearchPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: pages[controller.selectedIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTab,
        selectedItemColor: CustomColors.primaryLight,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_sharp),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: "Visits",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
        ],
      ),
     )
    );
  }
}
