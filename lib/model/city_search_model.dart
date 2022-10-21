// To parse this JSON data, do
//
//     final citySearch = citySearchFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CitySearch> citySearchFromJson(String str) =>
    List<CitySearch>.from(json.decode(str).map((x) => CitySearch.fromJson(x)));

String citySearchToJson(List<CitySearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CitySearch {
  CitySearch({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  String name;
  double lat;
  double lon;
  String country;
  String state;

  factory CitySearch.fromJson(Map<String, dynamic> json) => CitySearch(
        name: json["name"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        country: json["country"],
        state: json["state"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
