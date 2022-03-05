import 'package:first_flutter_app/weather_forecast/model/weather_forecast_model.dart';
import 'package:flutter/material.dart';

import 'forecast_card.dart';

class BottomView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;

  const BottomView({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "7-Day Weather Forecast".toUpperCase(),
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        height: 160,
                        child: forecastCard(snapshot, index),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFF9661C3), Colors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight))),
                  ),
              separatorBuilder: (context, index) => const SizedBox(
                    width: 8,
                  ),
              itemCount: forecastList?.length ?? 0),
        )
      ],
    );
  }
}