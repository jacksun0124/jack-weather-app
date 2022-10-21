import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:jack_weather_app/pages/home/home.dart';
import 'package:jack_weather_app/pages/search/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Weather App',
        theme: ThemeData(brightness: Brightness.dark),
        home: const Home(),
        getPages: [
          GetPage(name: '/', page: () => const Home()),
          GetPage(name: '/search', page: () => const Search()),
        ]);
  }
}
