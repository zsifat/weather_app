import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class WeatherUtils {
  static IconData getWeatherIcon(String condition) {
    switch (condition.trim()) {
      case "Sunny":
        return FontAwesomeIcons.solidSun;
      case "Mist":
        return FontAwesomeIcons.snowflake;
      case "Partly Cloudy":
        return FontAwesomeIcons.cloudSun;
      case "Clear":
        return FontAwesomeIcons.solidSun;
      case "Patchy rain nearby":
        return FontAwesomeIcons.cloudRain;
      default:
        return FontAwesomeIcons.sun;
    }
  }

  static Color getTemperatureColor(int temp) {
    if (temp <= 0) return Colors.blue;
    if (temp <= 15) return Colors.indigo;
    if (temp < 30) return Colors.deepPurple;
    return Colors.pink;
  }

  static String getDayName(int timeStamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('E').format(date);
  }
}
