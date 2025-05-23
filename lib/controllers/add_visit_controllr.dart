import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVisitController extends GetxController {
  int? selectedCustomerId;
  TextEditingController locationController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController visitDate = TextEditingController();
  TextEditingController visitTime = TextEditingController();
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> activities = [
    "Product Demo",
    "Contract Review",
    "Presentation",
    "Q&A Session",
    "Training"
  ];
  final List<Map<String, dynamic>> customers = [
  {"id": 1, "name": "Dennis Mutai"},
  {"id": 2, "name": "Jane Doe"},
  {"id": 3, "name": "John Smith"},
];
  RxList<String> selectedActivities = <String>[].obs;
}
