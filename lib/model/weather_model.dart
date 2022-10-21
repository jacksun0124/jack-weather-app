// To parse this JSON data, do
//
//     final weatherObject = weatherObjectFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<WeatherObject> weatherObjectFromJson(String str) =>
    List<WeatherObject>.from(
        json.decode(str).map((x) => WeatherObject.fromJson(x)));

String weatherObjectToJson(List<WeatherObject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeatherObject {
  WeatherObject({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });

  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  int pop;
  Sys sys;
  DateTime dtTxt;

  factory WeatherObject.fromJson(Map<String, dynamic> json) => WeatherObject(
        dt: json["dt"].toInt(),
        main: Main.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"].toInt(),
        pop: json["pop"].toInt(),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds.toJson(),
        "wind": wind.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys.toJson(),
        "dt_txt": dtTxt.toIso8601String(),
      };
}

class Clouds {
  Clouds({
    required this.all,
  });

  int all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  int temp;
  int feelsLike;
  int tempMin;
  int tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  int tempKf;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toInt(),
        feelsLike: json["feels_like"].toInt(),
        tempMin: json["temp_min"].toInt(),
        tempMax: json["temp_max"].toInt(),
        pressure: json["pressure"].toInt(),
        seaLevel: json["sea_level"].toInt(),
        grndLevel: json["grnd_level"].toInt(),
        humidity: json["humidity"].toInt(),
        tempKf: json["temp_kf"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

class Sys {
  Sys({
    required this.pod,
  });

  String pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"],
      );

  Map<String, dynamic> toJson() => {
        "pod": pod,
      };
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  int id;
  String main;
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"].toInt(),
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  int speed;
  int deg;
  int gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toInt(),
        deg: json["deg"].toInt(),
        gust: json["gust"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
