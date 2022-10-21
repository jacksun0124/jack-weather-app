import 'package:jack_weather_app/helper/dev_log.dart';

import '../config/config.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ConnectionService {
  fetchCity(String cityName) async {
    //fetch city data from api
    var response = await http.get(
        Uri.parse('$baseUrl/geo/1.0/direct?q=$cityName&limit=5&appid=$apiKey'));
    return response;
  }

  fetchWeather(latLon) async {
    var latitude = latLon['latitude'];
    var longitude = latLon['longitude'];

    String url =
        // "$baseUrl/data/2.5/forecast?lat=44.34&lon=10.99&units=metric&appid=$apiKey";

        "$baseUrl/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey";

    devLog("url: " + url);
    var response = await getData(url, "get");
    // devLog("fetchWeather response: " + response.body);
    return response;
  }

  getData(String link, String method, {Map<String, String>? header}) async {
    late http.Response response;
    bool hasError = false;
    int maxTry = 3;

    header = header ?? {};

    devLog("header: " + header.toString());
    devLog("finalUrl: " + link);

    do {
      devLog("maxTry: $maxTry");
      maxTry = maxTry - 1;

      try {
        if (method == "get") {
          devLog("response method get");
          response = await http.get(Uri.parse(link));
          devLog("getData response: " + response.body);
        }
      } catch (error) {
        devLog("error: " + error.toString());
        hasError = true;
      }

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then return response.
        // devLog("response.body: " + response.body.toString());

        hasError = false;
        return response;
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        devLog("Error: " + response.statusCode.toString());
        devLog('Failed to load: ' + link);

        hasError = true;
        if (maxTry >= 2) Get.snackbar("Server Issue", "Try relogin");
        return response;
      }
    } while (maxTry > 0 && hasError);
  }
}
