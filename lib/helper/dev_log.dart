import 'package:jack_weather_app/config/config.dart';

devLog(String s) {
  if (env == Environment.dev) {
    // ignore: avoid_print
    print(s);
  }
}
