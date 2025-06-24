import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:visita/constants/bottom_nav.dart';
import 'package:visita/controllers/add_visit_controllr.dart';
import 'package:visita/controllers/api_controller.dart';
import 'package:visita/firebase_options.dart';
import 'package:visita/sercvices/api_service.dart';
import 'package:visita/views/add_visits.dart';
import 'package:visita/views/home_page.dart';
import 'package:visita/views/search_page.dart';
import 'package:visita/views/visits.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(    
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      routes: {
        "/home":(page)=> HomePage(),
        "/visit":(page)=> Visits(),
        "/search":(page)=> SearchPage(),
        "/":(page)=> BottomNav(),
        "/add":(page)=> AddVisits(),
      },
    )
  );
}
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiController());
    Get.put(ApiService());
    Get.put(AddVisitController());
  }
}