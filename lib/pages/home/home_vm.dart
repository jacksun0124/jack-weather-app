import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:jack_weather_app/config/config.dart';
import 'package:jack_weather_app/helper/dev_log.dart';
import 'package:jack_weather_app/model/city_model.dart';
import 'package:jack_weather_app/model/city_search_model.dart';
import 'package:jack_weather_app/model/weather_model.dart';
import 'package:jack_weather_app/service/connection_service.dart';
import 'package:jack_weather_app/service/location_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  ConnectionService connect = ConnectionService();
  LocationService location = LocationService();
  City city = City(
      id: 0,
      name: '',
      coord: Coord(lat: 0, lon: 0),
      country: '',
      population: 0,
      timezone: 0,
      sunrise: 0,
      sunset: 0);
  WeatherObject? weather;
  List<WeatherObject> weatherObj = [];

  Map<String, double> _latLon = {};
  Map<String, double> get latLon => _latLon;

  bool hasError = false;
  bool sortAsc = true;

  init({citySearchObj}) async {
    //init the viewmodel
    devLog("HomeViewModel init");
    setBusy(true);
    if (citySearchObj != null) {
      devLog(
          "HomeViewModel init: citySearchObj has data - ${jsonEncode(citySearchObj)}");

      //get coordinates from citySearchObj
      _latLon = {'latitude': citySearchObj.lat, 'longitude': citySearchObj.lon};

      devLog("HomeViewModel init: latLon: $_latLon");

      //if citySearchObj is not null, then get the weather for the city
      await getWeather(_latLon);
    } else {
      //else get the weather for the current location
      await getLocation();
    }
    setBusy(false);
    notifyListeners();
  }

  getLocation() async {
    devLog("getLocation");

    if (env != Environment.test) {
      //get lat and lon of current location (cell phone gps)
      await location.getLatLon().then((value) async {
        devLog("value: " + value.toString());
        _latLon = {'latitude': value.latitude, 'longitude': value.longitude};
        await getWeather(latLon);
      });
    } else {
      //if in test environment, then use a static lat and lon
      _latLon = {'latitude': 40.7128, 'longitude': -74.0060};
      await getWeather(latLon);
    }

    notifyListeners();
  }

  getWeather(latLon) async {
    //set object busy to true
    setBusyForObject(weatherObj, true);
    setBusyForObject(city, true);
    setBusyForObject(weather, true);
    devLog("getWeather start");

    //get weather data from api
    var response = await connect.fetchWeather(latLon);

    //if statusCode is 200, then parse the response
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var rest = data["list"] as List;

      //convert the response to a list of WeatherObject
      weatherObj = weatherObjectFromJson(jsonEncode(rest));
      setBusyForObject(weatherObj, false);

      //get the first weather from the list
      weather = weatherObj[0];
      setBusyForObject(weather, false);

      //convert the response to a City object
      city = City.fromJson(data["city"]);
      devLog("city: " + city!.name.toString());
      setBusyForObject(city, false);
    } else {
      hasError = true;
    }
    notifyListeners();
  }

  sortDate() {
    //sort the list of weather by date
    setBusyForObject(weatherObj, true);
    sortAsc = !sortAsc;
    if (sortAsc) {
      weatherObj.sort((a, b) => a.dt.compareTo(b.dt));
    } else {
      weatherObj.sort((a, b) => b.dt.compareTo(a.dt));
    }
    setBusyForObject(weatherObj, false);
    notifyListeners();
  }
}
