import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/api_result_model.dart';
import 'package:flutter_app/res/string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewScreen extends StatefulWidget {

  List<Welcome> list;

  NewScreen({Key key, @required this.list}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState(list: list);
}

class _NewScreenState extends State<NewScreen> {
  List<Welcome> list;

  _NewScreenState({@required this.list});

  Future<Widget> buildDataList() async{
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (ctx, pos) {
          return Center(child: Text(list[pos].city + "   " + list[pos].state + "   " + list[pos].country + "   " + list[pos].name),);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            tooltip: 'Refresh',
            onPressed: () async {
              final response = await http.get(AppStrings.apiUrl);
              if(response.statusCode == 200){
                Map<String, Welcome> dataList = welcomeFromJson(response.body);
                print(">>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<");
                dataList.forEach((key, value) {
                  list.add(value);
                });
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                final String encodedStringList = Welcome.encode([for(int i=0;i<list.length;i++) list[i]]);
                await sharedPreferences.setString('list', encodedStringList);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (ctx, pos) {
              return Center(child: Text(widget.list[pos].city + "   " + widget.list[pos].state + "   " + widget.list[pos].country + "   " + widget.list[pos].name, style: const TextStyle(fontSize: 12, color: Colors.pinkAccent),),);
            }
        ),
      ),
    );
  }
}
