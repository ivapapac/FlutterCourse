import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:first_flutter_app/weather_forecast/network/network.dart';
import 'package:first_flutter_app/weather_forecast/ui/bottom_view.dart';
import 'package:first_flutter_app/weather_forecast/ui/mid_view.dart';
import 'package:flutter/material.dart';

class WeatherForecast extends StatefulWidget {
  const WeatherForecast({Key? key}) : super(key: key);

  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  late Future<WeatherForecastModel> forecast;
  String _cityName = 'Koprivnica';

  @override
  void initState() {
    super.initState();
    forecast = getWeather(cityName: _cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          textFieldView(),
          FutureBuilder<WeatherForecastModel>(
            future: forecast,
            builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    MidView(snapshot: snapshot),
                    BottomView(snapshot: snapshot),
                  ],
                );
              } else {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget textFieldView() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Enter City Name",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: const EdgeInsets.all(8)),
        onSubmitted: (value) {
          setState(() {
            _cityName = value;
            forecast = getWeather(cityName: _cityName);
          });
        },
      ),
    );
  }

  Future<WeatherForecastModel> getWeather({required String cityName}) =>
      Network().getWeatherForecast(cityName: cityName);
}
