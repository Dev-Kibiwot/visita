import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visita/constants/custom_appbar.dart';
import 'package:visita/constants/helpers/visit_page_helpers.dart';
import 'package:visita/constants/visit_card.dart';
import 'package:visita/controllers/api_controller.dart';
import 'package:visita/controllers/search_controller.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/utils/input.dart';
import 'package:visita/utils/text.dart';

class SearchPage extends StatelessWidget {
  final SearchFilterController searchController = Get.put(SearchFilterController());
  final ApiController apiController = Get.find<ApiController>();
  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: CustomAppbar(title: "Search"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CustomTextInput(
              controller: searchController.search,
              validator: (value) {
                return null;
              },
              textInputType: TextInputType.text,
              hintText: "Search by visit, customer or location",
              label: "",
              suffix: GestureDetector(
                onTap: () {
                  searchController.toggleVisible();
                },
                child: Icon(
                  Icons.filter_list_sharp,
                  size: 25,
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
            visible: searchController.visible.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 10),
                  child: CustomText(
                    text: "Filter by:",
                    fontSize: 18,
                    textColor: CustomColors.blak,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => GestureDetector(
                        onTap: () => searchController.setStatus("Completed"),
                        child: StatusBadge(
                          status: "Completed",
                          isSelected: searchController.selectedStatus.value == "Completed",
                        ),
                        )
                      ),
                      Obx(() => GestureDetector(
                        onTap: () => searchController.setStatus("Pending"),
                        child: StatusBadge(
                          status: "Pending",
                          isSelected: searchController.selectedStatus.value == "Pending",
                        ),
                      )
                      ),
                      Obx(() => GestureDetector(
                        onTap: () => searchController.setStatus("Cancelled"),
                        child: StatusBadge(
                          status: "Cancelled",
                          isSelected: searchController.selectedStatus.value == "Cancelled",
                        ),
                        )
                      ),
                    ],
                    ),
                  ),
                ],
              ),
            )
          ),
          Obx(() {
            final visits = apiController.data['visits'] ?? [];
            final customers = apiController.data['customers'] ?? [];
            final filteredVisits = visits.where((visit) {
              final searchText = searchController.searchText.value.toLowerCase();
              final matchText = visit['notes'].toString().toLowerCase().contains(searchText) ||visit['location'].toString().toLowerCase().contains(searchText) ||visit['status'].toString().toLowerCase().contains(searchText);
              final matchStatus = searchController.selectedStatus.value.isEmpty ||visit['status'] == searchController.selectedStatus.value;
              return matchText && matchStatus;
            }).toList();
            return Column(
              children: filteredVisits.map<Widget>((visit) {
                final customer = customers.firstWhere( (val) => val['id'] == visit['customer_id']);
                return VisitCard(
                  customerName: customer['name'],
                  status: visit['status'],
                  date: visit['visit_date'].substring(0, 10),
                  time: visit['visit_date'].substring(11, 16),
                  location: visit['location'],
                  activities: [],
                  notes: visit['notes'],
                );
              }).toList(),
            );
           }
          )
        ],
      ),
    );
  }
}
