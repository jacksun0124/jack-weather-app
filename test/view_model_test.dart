import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jack_weather_app/model/city_search_model.dart';
import 'package:jack_weather_app/model/weather_model.dart';
import 'package:jack_weather_app/pages/home/home_vm.dart';
import 'package:jack_weather_app/pages/search/search_vm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('test HomeViewModel', () async {
    var vm = HomeViewModel();

    await vm.init();
    //expect vm.city.name not to be empty
    expect(vm.city.name, isNotEmpty);

    //expect vm.city.name is String
    expect(vm.city.name, isA<String>());

    // expect vm.city.country not to be empty
    expect(vm.city.country, isNotEmpty);

    //expect vm.city.country is String
    expect(vm.city.country, isA<String>());

    //expect latLon is not null
    expect(vm.latLon, isNotNull);

    // expect latitute has key latitute
    expect(vm.latLon.containsKey('latitude'), isTrue);

    // expect longitude has key longitude
    expect(vm.latLon.containsKey('longitude'), isTrue);

    // expect weatherObj is not empty
    expect(vm.weatherObj, isNotEmpty);

    // expect weatherObj is List
    expect(vm.weatherObj, isA<List>());

    // expect weatherObj is List of WeatherObject
    expect(vm.weatherObj, isA<List<WeatherObject>>());
  });

  test('test SearchViewModel', () async {
    var vm = SearchViewModel();

    vm.selectCity("London");

    // expect searchController.text = "London"
    expect(vm.searchController.text, "London");

    await vm.search();

    //expect vm.citySearch is not null
    expect(vm.citySearch, isNotNull);

    //expect vm.citySearch is List<CitySearch>
    expect(vm.citySearch, isA<List<CitySearch>>());

    //expect vm.citySearch length > 0
    expect(vm.citySearch.length, greaterThan(0));

    //expect vm.citySearch[0] is CitySearch
    expect(vm.citySearch[0], isA<CitySearch>());

    //expect vm.citySearch[0].name is String
    expect(vm.citySearch[0].name, isA<String>());
  });
}
