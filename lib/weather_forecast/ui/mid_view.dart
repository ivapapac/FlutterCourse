import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/util/convert_icon.dart';
import 'package:first_flutter_app/weather_forecast/util/forecast_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MidView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const MidView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$city, $country",
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
          ),
          Text(
            Util.getFormattedDate(forecastList?[0].dt),
            style: const TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: getWeatherIcon(
                weatherDescription: "${forecastList?[0].weather?[0].main}",
                color: Colors.pinkAccent,
                size: 198),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${forecastList?[0].temp?.day?.toStringAsFixed(0)}°C",
                  style: const TextStyle(fontSize: 34),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(" ${forecastList?[0].weather?[0].description?.toUpperCase()}"),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${forecastList?[0].speed?.toStringAsFixed(1)} km/h"),
                      const Icon(
                        FontAwesomeIcons.wind,
                        size: 20,
                        color: Colors.brown,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${forecastList?[0].humidity?.toStringAsFixed(0)} %"),
                      const Icon(FontAwesomeIcons.solidGrinBeamSweat, size: 20, color: Colors.brown)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${forecastList?[0].temp?.max?.toStringAsFixed(0)} °C"),
                      const Icon(
                        FontAwesomeIcons.temperatureHigh,
                        size: 20,
                        color: Colors.brown,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
