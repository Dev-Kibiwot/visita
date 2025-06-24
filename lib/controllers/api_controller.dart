import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:visita/sercvices/api_service.dart';
import 'package:intl/intl.dart';

class ApiController extends GetxController {
  final ApiService apiService = ApiService();
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  RxInt pendingCount = 0.obs;
  RxInt completedCount = 0.obs;
  RxInt cancelledCount = 0.obs;
  RxInt allvisits = 0.obs;
  RxDouble successRate = 0.0.obs;
  RxBool isloading = false.obs;
  final List<String> categories = ['customers', 'activities', 'visits'];

 Future<void> getData() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      Get.snackbar("No Internet", "Please check your connection.");
      return;
    }
    try {
      isloading.value = true;
      for (var category in categories) {
        final result = await apiService.fetchData(category);
        data[category] = result;
      }
      calculateVisits();
    } catch (e) {
      Get.snackbar("Error", "Error fetching data: $e");
    } finally {
      isloading.value = false;
    }
  }

  void calculateVisits() {
    final visits = data['visits'];
    pendingCount.value = 0;
    completedCount.value = 0;
    cancelledCount.value = 0;
    if (visits != null && visits is List) {
      for (var visit in visits) {
        final status = visit['status'];
        if (status == 'Pending') {
          pendingCount.value++;
        } else if (status == 'Completed') {
          completedCount.value++;
        } else if (status == 'Cancelled') {
          cancelledCount.value++;
        }
      }
      allvisits.value = pendingCount.value + completedCount.value + cancelledCount.value;
      if (allvisits.value > 0) {
        successRate.value = (completedCount.value / allvisits.value) * 100;
      } else {
        successRate.value = 0.0;
      }
    }
  }
 
  String formatVisitDate(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate.trim());
      return DateFormat('dd MMM yyyy').format(dateTime.toLocal());
    } catch (e) {
      return '30 Apr 2025';
    }
  }
 
  String formatVisitTime(String rawDate) {
    try {
      final dateTime = DateTime.parse(rawDate.trim());
      return DateFormat('hh:mm a').format(dateTime.toLocal());
    } catch (e) {
      return '08:25 AM';
    }
  }
 
  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
