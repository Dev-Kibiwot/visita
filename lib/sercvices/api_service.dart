import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ApiService extends GetConnect{
  List response = [];  
  Future <List> fetchData(String category)async{
    final results = await get(
      "${dotenv.env['BASE_URL']}$category",
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
}