import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/api_result_model.dart';

class NewScreen extends StatefulWidget {

  Welcome listInfo;

  NewScreen({Key key, @required this.listInfo}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState(listInfo: listInfo);
}

class _NewScreenState extends State<NewScreen> {
  Welcome listInfo;

  _NewScreenState({@required this.listInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(listInfo.name),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            ListTile(title: Text("icao: ${listInfo.icao}")),
            ListTile(title: Text("state: ${listInfo.state}")),
            ListTile(title: Text("name: ${listInfo.name}")),
            ListTile(title: Text("country: ${listInfo.country}")),
            ListTile(title:  Text("city: ${listInfo.city}")),
            ListTile(title: Text("iata: ${listInfo.iata}")),
            ListTile(title: Text("tz: ${listInfo.tz}")),
            ListTile(title: Text("elevation: ${listInfo.elevation}")),
            ListTile(title: Text("lat: ${listInfo.lat}")),
            ListTile(title: Text("lon: ${listInfo.lon}"))
          ],
        )
      ),
    );
  }
}
