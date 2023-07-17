import 'package:dio/dio.dart';
import 'package:flutter_bloc_event_counter_app/bloc_api/model/user_model.dart';

class ApiService {
  Future<List<UserModel>> getData() async {
    List<UserModel> userDataList = [];

    final Dio _dio = Dio();
    try {
      Response response =
          await _dio.get("https://jsonplaceholder.typicode.com/users");
      print(response.data);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        for (var element in data) {
          UserModel userModel = UserModel.fromJson(element);
          userDataList.add(userModel);
        }
        return userDataList;
      } else {
        return [];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
