import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_app/data/model/api_result_model.dart';
import 'package:flutter_app/res/string.dart';
import 'package:http/http.dart' as http;

class ApiRepository{
  List<Welcome> myDataList;

  ApiRepository() {
    myDataList = myDataList ??  [];
  }

  Future<bool> checkConnectivityState() async {
    try{
      final ConnectivityResult result = await Connectivity().checkConnectivity();
      if(result == ConnectivityResult.wifi){
        return true;
      }
      else if(result == ConnectivityResult.mobile){
        return true;
      }
      else{
        return false;
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  Future<List<Welcome>> getData() async {
        try{
          bool connection = await checkConnectivityState();
          print(connection);
          if(connection == true){
            final response = await http.get(AppStrings.apiUrl);
            if(response.statusCode == 200){
              Map<String, Welcome> dataList = welcomeFromJson(response.body);
              print(">>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<");
              print(dataList);
              myDataList = [];
              dataList.forEach((key, value) {
                myDataList.add(value);
              });
              print(myDataList.length);
              print("completed...........................");
              return myDataList;
            }
          }
          else{
            return myDataList;
          }
        }catch(e){
          throw Exception(e.toString());
        }
  }
}