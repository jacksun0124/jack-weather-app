import 'package:flutter/material.dart';
import 'package:jack_weather_app/helper/dev_log.dart';
import 'package:jack_weather_app/model/city_search_model.dart';
import 'package:jack_weather_app/service/connection_service.dart';
import 'package:stacked/stacked.dart';

class SearchViewModel extends BaseViewModel {
  //input controller
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  ConnectionService connect = ConnectionService();
  List<CitySearch> citySearch = [];

  String t = "Search";

  init() async {
    //init the viewmodel
    devLog("SearchViewModel init");
    setBusy(true);

    setBusy(false);
    notifyListeners();
  }

  search() async {
    //search for city
    setBusyForObject(citySearch, true);
    devLog('search: ${_searchController.text}');

    String cityName = _searchController.text;
    var response = await connect.fetchCity(cityName);

    //if statusCode is 200, then parse the response
    if (response.statusCode == 200) {
      citySearch = citySearchFromJson(response.body);
      devLog('citySearch: ${citySearch.length}');
    } else {
      devLog('error: ${response.statusCode} ${response.body}');
    }

    setBusyForObject(citySearch, false);
    notifyListeners();
  }

  String getCityString(CitySearch city) {
    //get city string, ex: "New York, US"
    String text = city.state == ""
        ? '${city.name}, ${city.country}'
        : '${city.name}, ${city.state}, ${city.country}';
    devLog("getCityString: $text");
    return text;
  }

  //set _searchController.text to the selected city
  selectCity(String city) {
    devLog("selectCity: $city");
    _searchController.text = city;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _searchController.dispose();
    super.dispose();
  }
}
