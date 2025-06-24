import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visita/controllers/add_visit_controllr.dart';
import 'package:visita/controllers/api_controller.dart';
import 'package:visita/utils/colors.dart';
import 'package:visita/utils/input.dart';
import 'package:visita/utils/text.dart';

class AddVisits extends StatelessWidget {
  AddVisits({super.key});
  final ApiController apiController = Get.find<ApiController>(); 
  final AddVisitController addVisitControllr = Get.find<AddVisitController>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add visit"
        ),
      ),
      body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: addVisitControllr.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Customer"),
            Obx(() {
              final customers = apiController.data['customers'] ?? [];
              return DropdownButtonFormField<int>(
                value: addVisitControllr.selectedCustomerId,
                decoration: InputDecoration(
                  fillColor: CustomColors.secondary,
                  hintText: "Select customer",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.blak),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: CustomColors.blak),
                  ),
                ),
                items: customers.map<DropdownMenuItem<int>>((customer) {
                  return DropdownMenuItem<int>(
                    value: customer["id"],
                    child: CustomText(
                      text: customer["name"],
                      fontSize: 16,
                      textColor: CustomColors.blak,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  addVisitControllr.selectedCustomerId = value;
                },
              );
             }
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2025),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            addVisitControllr.selectedDate.value = picked;
                            addVisitControllr.visitDate.text ="${picked.day}/${picked.month}/${picked.year}";
                          }
                        },
                        child: CustomTextInput(
                            controller: addVisitControllr.visitDate,
                            validator: (value) {
                              return value == "" ? "Enter valid date" : null;
                            },
                            enable: false,
                            textInputType: TextInputType.datetime,
                            hintText: "dd/mm/yyyy",
                            label: "Visit Date",
                            suffix: Icon(Icons.calendar_today),
                          ),
                      )
        
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     GestureDetector(
                        onTap: () async {
                          TimeOfDay? picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) {
                            addVisitControllr.selectedTime.value = picked;
                            addVisitControllr.visitTime.text = picked.format(context);
                          }
                        },
                        child: CustomTextInput(
                          controller: addVisitControllr.visitTime,
                          validator: (value) {
                            return value == "" ? "Enter valid time" : null;
                          },
                          enable: false,
                          textInputType: TextInputType.text,
                          hintText: "10:00",
                          label: "Visit Time",
                          suffix: Icon(Icons.access_time),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomTextInput(
              controller: addVisitControllr.locationController, 
              validator: (value){
                return value == "" ? "Enter valid location" : "";
              }, 
              textInputType: TextInputType.text, 
              hintText: "Enter visit location", 
              label: "Location"
            ),
            SizedBox(height: 16),
            Text("Activities"),
            Obx(() {
              final activities = apiController.data['activities'] ?? [];
              if (activities.isEmpty) {
                return Center(child: Text("No activities found"));
              }
              return Column(
                children: activities.map<Widget>((activity) {
                  final name = activity['description']; 
                  return CheckboxListTile(
                    title: Text(
                      name,
                      style: TextStyle(fontSize: 14),
                    ),
                    value: addVisitControllr.selectedActivities.contains(name),
                    onChanged: (checked) {
                      if (checked == true) {
                        addVisitControllr.selectedActivities.add(name);
                      } else {
                        addVisitControllr.selectedActivities.remove(name);
                      }
                    },
                  );
                }).toList(),
              );
             }
            ),
            SizedBox(height: 16),
            CustomTextInput(
              controller: addVisitControllr.notesController, 
              validator: (value){
                return value == "" ? "Enter notes " : "";
              }, 
              textInputType: TextInputType.text, 
              hintText: "Add any additional notes", 
              label: "Notes"
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                addVisitControllr.submitVisit();              
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width *0.05
                ),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.primaryText,
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          text: "Upload visit", 
                          fontSize: 18, 
                          textColor: CustomColors.secondary
                        ),
                      ),
                    ),
                   ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05
             ),
            ],
          ),
        ),
      )
    );
  }
}