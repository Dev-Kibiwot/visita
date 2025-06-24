import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SearchFilterController extends GetxController {
  final search = TextEditingController();
  RxString searchText = ''.obs;
  RxBool visible = false.obs;
  RxString selectedStatus = ''.obs;
  @override
  void onInit() {
    super.onInit();
    search.addListener(() {
      searchText.value = search.text;
    });
  }
  void toggleVisible() {
    visible.value = !visible.value;
  }
  void setStatus(String status) {
    selectedStatus.value = selectedStatus.value == status ? '' : status;
  }
  void clearFilters() {
    search.clear();
    searchText.value = '';
    selectedStatus.value = '';
  }
}
