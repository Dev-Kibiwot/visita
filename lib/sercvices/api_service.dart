import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:visita/controllers/add_visit_controllr.dart';

class ApiService extends GetConnect{
  AddVisitController get addVisitController => Get.find<AddVisitController>();
  List response = [];

  Future<bool> isOnline() async {
    var result = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return result != ConnectivityResult.none;
  }
  Future <List> fetchData(String category)async{
    final results = await get(
      "${dotenv.env['BASE_URL']}/$category",
      headers: {
        "Accept":"application/json",
        "apikey" : "${dotenv.env['API_KEY']}"
      }
    );
    if (results.statusCode == 200) {
      response = results.body;
    }
    return response;
  }
  
  Future<void> postVisit(Map<String, dynamic> visitData) async {
    final url = Uri.parse('${dotenv.env['BASE_URL']}/visits');
    final online = await isOnline();
    if (!online) {
      await addVisitController.cacheVisit(visitData);
      Get.snackbar("Offline", "Visit saved locally. Will sync when online.");
      return;
    }
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'apikey': dotenv.env['API_KEY']!,
      },
      body: jsonEncode(visitData),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.snackbar("Success", "Visit added successfully");
    } else {
      await addVisitController.cacheVisit(visitData);
      Get.snackbar("Saved to device", "Will upto when online");
      throw Exception('Failed to add visit');
    }
  }
}