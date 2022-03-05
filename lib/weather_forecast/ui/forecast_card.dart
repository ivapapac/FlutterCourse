import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/util/convert_icon.dart';
import 'package:first_flutter_app/weather_forecast/util/forecast_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecastModel> snapshot, int index) {
  var forecastList = snapshot.data?.list;
  var fullDate = Util.getFormattedDate(forecastList?[index].dt);
  var dayOfWeek = fullDate.split(",")[0];

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(dayOfWeek),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: getWeatherIcon(
                weatherDescription: forecastList?[index].weather?[0].main,
                size: 30,
                color: Colors.pinkAccent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(children: [
                  const Icon(
                    FontAwesomeIcons.cloudSun,
                    size: 15,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("${forecastList?[index].temp?.morn?.toStringAsFixed(0)}°C"),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidMoon,
                      size: 15,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("${forecastList?[index].temp?.eve?.toStringAsFixed(0)}°C"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidGrinBeamSweat,
                      size: 15,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("${forecastList?[index].humidity} %"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.wind,
                      size: 15,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text("${forecastList?[index].speed} km/h"),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      )
    ],
  );
}
