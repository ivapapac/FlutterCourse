import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget getWeatherIcon({String? weatherDescription, Color? color, double? size}) {
  switch (weatherDescription) {
    case "Clouds":
      {
        return Icon(
          FontAwesomeIcons.cloud,
          color: color,
          size: size,
        );
      }
    case "Rain":
      {
        return Icon(
          FontAwesomeIcons.cloudRain,
          color: color,
          size: size,
        );
      }
    case "Snow":
      {
        return Icon(
          FontAwesomeIcons.snowflake,
          color: color,
          size: size,
        );
      }
    default:
      {
        return Icon(
          FontAwesomeIcons.sun,
          color: color,
          size: size,
        );
      }
  }
}
