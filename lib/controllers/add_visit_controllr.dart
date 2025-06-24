import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:visita/controllers/api_controller.dart';
import 'package:visita/sercvices/api_service.dart';

class AddVisitController extends GetxController {
  ApiController get apiController => Get.find<ApiController>();
  int? selectedCustomerId;
  TextEditingController locationController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController visitDate = TextEditingController();
  TextEditingController visitTime = TextEditingController();
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<String> selectedActivities = <String>[].obs;
  final ApiService service = ApiService();

  Future<void> submitVisit() async {
    try {
      if (selectedCustomerId == null || selectedDate.value == null || selectedTime.value == null) {
        Get.snackbar("Error", "Please complete all required fields");
        return;
      }
      final visitDateTime = DateTime(
        selectedDate.value!.year,
        selectedDate.value!.month,
        selectedDate.value!.day,
        selectedTime.value!.hour,
        selectedTime.value!.minute,
      ).toUtc();
        final activities = apiController.data['activities'] ?? [];
        final selectedIds = activities.where((a) => selectedActivities.contains(a['description'])) .map((a) => '${a['id']}').toList();
        final visitData = {
          "customer_id": selectedCustomerId,
          "visit_date": visitDateTime.toIso8601String(),
          "status": "Pending",
          "location": locationController.text,
          "notes": notesController.text,
          "activities_done": selectedIds,
        };
        await service.postVisit(visitData);
        Get.snackbar("Success", "Visit added successfully");
      } catch (e) {
       Get.snackbar("Error", "Failed to submit visit");
    }
  }
 
  Future<void> cacheVisit(Map<String, dynamic> visitData) async {
  final box = await Hive.openBox('offline_visits');
  await box.add(visitData);
 }
  
  Future<void> syncCachedVisits() async {
    final box = await Hive.openBox('offline_visits');
    final List cached = box.values.toList();
    for (var visit in cached) {
      try {
        await service.postVisit(Map<String, dynamic>.from(visit));
        await box.deleteAt(0); 
      } catch (_) {
        break; 
      }
    }
  }
}
