// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Map<String, Welcome> welcomeFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Welcome>(k, Welcome.fromJson(v)));

String welcomeToJson(Map<String, Welcome> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Welcome {
  Welcome({
    this.icao,
    this.iata,
    this.name,
    this.city,
    this.state,
    this.country,
    this.elevation,
    this.lat,
    this.lon,
    this.tz,
  });

  String icao;
  String iata;
  String name;
  String city;
  String state;
  String country;
  int elevation;
  double lat;
  double lon;
  String tz;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    icao: json["icao"],
    iata: json["iata"] == null ? null : json["iata"],
    name: json["name"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    elevation: json["elevation"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    tz: json["tz"],
  );

  Map<String, dynamic> toJson() => {
    "icao": icao,
    "iata": iata == null ? null : iata,
    "name": name,
    "city": city,
    "state": state,
    "country": country,
    "elevation": elevation,
    "lat": lat,
    "lon": lon,
    "tz": tz,
  };

  static Map<String, dynamic> toMap(Welcome dList) => {
    "icao": dList.icao,
    "iata": dList.iata,
    "name": dList.name,
    "city": dList.city,
    "state": dList.state,
    "country": dList.country,
    "elevation": dList.elevation,
    "lat": dList.lat,
    "lon": dList.lon,
    "tz": dList.tz,
  };

  static String encode(List<Welcome> list) => json.encode(list.map<Map<String, dynamic>>((e) => Welcome.toMap(e)).toList());

  static List<Welcome> dencode(String list) => (json.decode(list) as List<dynamic>).map<Welcome>((e) => Welcome.fromJson(e)).toList();
}
